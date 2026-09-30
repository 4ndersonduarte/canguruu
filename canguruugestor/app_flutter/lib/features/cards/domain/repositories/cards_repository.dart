import '../../../../core/civil_date.dart';
import '../../../../core/money.dart';
import '../models.dart';
import '../services/card_rules.dart';

abstract interface class CardsRepository {
  Stream<CardsSnapshot> watch();
  Future<CardsSnapshot> read({CivilDate? asOf});
  Future<String> createCard({
    required String requestId,
    required String name,
    required Money totalLimit,
    required int closingDay,
    required int dueDay,
    required ClosingPolicy policy,
    required CivilDate openedOn,
    Money openingDebt = Money.zero,
  });
  Future<String> purchase({
    required String requestId,
    required String cardId,
    required String categoryId,
    required String description,
    required Money total,
    required int installments,
    required CivilDate date,
    required CivilDate billingOn,
    bool confirmClosedCycle = false,
  });
  Future<String> payInvoice({
    required String requestId,
    required String invoiceId,
    required String accountId,
    required Money amount,
    required CivilDate date,
  });
}
