import 'package:uuid/uuid.dart';
import '../../../core/civil_date.dart';
import '../../../core/failure.dart';
import '../../../core/money.dart';
import '../../../persistence/database.dart' show CanguruuDatabase;
import '../../../persistence/ledger_writer.dart';
import '../../finance/data/local_finance_repository.dart';
import '../../finance/domain/services/ledger_rules.dart';
import '../domain/models.dart';
import '../domain/repositories/goals_repository.dart';
import 'goal_codec.dart';

final class LocalGoalsRepository implements GoalsRepository {
  LocalGoalsRepository(this.db,this.clock,{String Function()? newId}):newId=newId ?? const Uuid().v4;
  final CanguruuDatabase db;
  final Clock clock;
  final String Function() newId;
  LedgerWriter get writer=>LedgerWriter(db,clock,newId);
  String get now=>clock.utcNow.toUtc().toIso8601String();
  Future<List<Map<String,Object?>>> rows(String table) async =>
    (await db.customSelect('SELECT * FROM $table').get()).map((r)=>r.data).toList();
  Future<void> insert(String table,Map<String,Object?> data)=>db.customStatement(
    'INSERT INTO $table (${data.keys.join(',')}) VALUES (${List.filled(data.length,'?').join(',')})',data.values.toList());
  Never fail(String message)=>throw FinanceFailure('invalid_goal',message);
  @override
  Stream<GoalsSnapshot> watch()=>db.customSelect('SELECT count(*) FROM goals',readsFrom:db.allTables.toSet()).watch().asyncMap((_)=>read());
  @override
  Future<GoalsSnapshot> read()=>db.transaction(() async {
    final goals=(await rows('goals')).map(GoalCodec.goal).toList()
      ..sort((a,b){final p=a.priority.compareTo(b.priority);return p!=0?p:a.id.compareTo(b.id);});
    return GoalsSnapshot(objectives:(await rows('objectives')).map(GoalCodec.objective).toList(),
      goals:goals,movements:(await rows('goal_fund_movements')).map(GoalCodec.movement).toList()
        ..sort((a,b)=>a.sequence.compareTo(b.sequence)),
      finance:await LocalFinanceRepository(db,clock).read());
  });
  void checkRevision(int current,int? expected) {
    if(current!=expected) throw const FinanceFailure('stale_revision','Este registro mudou. Feche e abra novamente para atualizar.');
  }
  @override
  Future<String> saveObjective({required String requestId,required String title,String? id,
    int? revision,ObjectiveStatus status=ObjectiveStatus.active}) {
    final name=LedgerRules.name(title,max:80);
    return writer.command(requestId,'save_objective',[id,revision,name,status.name],() async {
      final snap=await read();
      if(id==null) {
        if(status!=ObjectiveStatus.active) fail('Crie o objetivo como ativo.');
        final key=newId();
        await insert('objectives',{'id':key,'profile_id':'local','title':name,'status':status.name,'created_at':now,'updated_at':now,'revision':1});
        return key;
      }
      final old=snap.objectives.where((o)=>o.id==id).firstOrNull;
      if(old==null) fail('Objetivo não encontrado.');
      checkRevision(old.revision,revision);
      if(status!=ObjectiveStatus.active && snap.goals.any((g)=>g.objectiveId==id&&!g.closed)) {
        fail('Conclua, arquive ou desvincule as metas antes de encerrar o objetivo.');
      }
      await db.customStatement('UPDATE objectives SET title=?,status=?,updated_at=?,revision=revision+1 WHERE id=?',[name,status.name,now,id]);
      return id;
    });
  }
  @override
  Future<String> saveGoal({required String requestId,required String title,required Money target,
    required GoalPurpose purpose,required int priority,String? objectiveId,CivilDate? targetOn,
    String? id,int? revision}) {
    final name=LedgerRules.name(title,max:80);
    if(target.cents<=0 || priority<1 || priority>5) fail('Informe um alvo positivo e uma prioridade de 1 a 5.');
    return writer.command(requestId,'save_goal',[id,revision,name,target.cents,purpose.name,priority,objectiveId,targetOn?.toString()],() async {
      final snap=await read();
      if(objectiveId!=null && !snap.objectives.any((o)=>o.id==objectiveId&&o.status==ObjectiveStatus.active)) fail('Escolha um objetivo ativo.');
      if(id==null) {
        if(targetOn!=null && targetOn.isBefore(clock.today)) fail('Escolha um prazo a partir de hoje.');
        final key=newId();
        await insert('goals',{'id':key,'profile_id':'local','objective_id':objectiveId,'title':name,'purpose':purpose.name,
          'target_cents':target.cents,'target_on':targetOn?.toString(),'priority':priority,'status':'active',
          'fulfilled_on':null,'fulfilled_cents':null,'created_at':now,'updated_at':now,'revision':1});
        return key;
      }
      final old=snap.goals.where((g)=>g.id==id).firstOrNull;
      if(old==null||old.closed) fail('Esta meta não está aberta para edição.');
      checkRevision(old.revision,revision);
      if(targetOn!=null && targetOn.isBefore(clock.today) && targetOn!=old.targetOn) fail('Escolha um prazo a partir de hoje.');
      await db.customStatement('UPDATE goals SET objective_id=?,title=?,purpose=?,target_cents=?,target_on=?,priority=?,updated_at=?,revision=revision+1 WHERE id=?',
        [objectiveId,name,purpose.name,target.cents,targetOn?.toString(),priority,now,id]);
      return id;
    });
  }
  Future<String> addMovement(String requestId,String goalId,String accountId,Money amount) async {
    final movements=await rows('goal_fund_movements');
    var sequence=0;
    for(final r in movements) {if((r['sequence_no'] as int)>sequence) sequence=r['sequence_no'] as int;}
    final id=newId();
    await insert('goal_fund_movements',{'id':id,'profile_id':'local','goal_id':goalId,'account_id':accountId,
      'effective_on':'${clock.today}','amount_cents':amount.cents,'sequence_no':sequence+1,'request_id':requestId,'created_at':now});
    return id;
  }
  @override
  Future<String> moveFunds({required String requestId,required String goalId,required String accountId,required Money amount}) =>
    writer.command(requestId,'move_goal_funds',[goalId,accountId,amount.cents],() async {
      if(amount.cents==0) fail('Informe um valor maior que zero.');
      final snap=await read();
      final goal=snap.goals.where((g)=>g.id==goalId).firstOrNull;
      if(goal==null||goal.closed) fail('Esta meta não aceita alterações de reserva.');
      final account=snap.finance.accounts.where((a)=>a.id==accountId).firstOrNull;
      if(account==null||account.archived) fail('Escolha uma conta ativa.');
      if(amount.cents>0) {
        if(goal.status!=GoalStatus.active) fail('Retome a meta antes de reservar.');
        if(amount.cents>snap.freeIn(accountId).cents) fail('O valor supera o saldo livre desta conta.');
      } else if(-amount.cents>(snap.reservedIn(accountId)[goalId]?.cents ?? 0)) {
        fail('O valor supera a reserva desta meta na conta.');
      }
      final id=await addMovement(requestId,goalId,accountId,amount);
      // Reservations change alongside the revision so stale lifecycle actions fail.
      await db.customStatement('UPDATE goals SET updated_at=?,revision=revision+1 WHERE id=?',[now,goalId]);
      final after=await read();
      after.reserved; after.covered; after.free;
      return id;
    });
  @override
  Future<String> setStatus({required String requestId,required String goalId,required int revision,required GoalStatus status}) =>
    writer.command(requestId,'set_goal_status',[goalId,revision,status.name],() async {
      final snap=await read();
      final goal=snap.goals.where((g)=>g.id==goalId).firstOrNull;
      if(goal==null||goal.closed) fail('Esta meta já foi encerrada.');
      checkRevision(goal.revision,revision);
      final progress=snap.progress.firstWhere((p)=>p.goal.id==goalId);
      if(status==GoalStatus.fulfilled && progress.covered.cents<goal.target.cents) fail('A reserva coberta ainda não atingiu o alvo.');
      final close=status==GoalStatus.fulfilled||status==GoalStatus.archived;
      if(close) {
        for(final a in snap.finance.accounts) {
          final nominal=snap.reservedIn(a.id)[goalId] ?? Money.zero;
          if(nominal.cents>0) await addMovement(':',goalId,a.id,Money(-nominal.cents));
        }
      }
      await db.customStatement('UPDATE goals SET status=?,fulfilled_on=?,fulfilled_cents=?,updated_at=?,revision=revision+1 WHERE id=?',
        [status.name,status==GoalStatus.fulfilled?'${clock.today}':null,status==GoalStatus.fulfilled?progress.covered.cents:null,now,goalId]);
      return goalId;
    });
}
