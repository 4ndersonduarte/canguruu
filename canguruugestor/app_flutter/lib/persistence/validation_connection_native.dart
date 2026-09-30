import 'package:drift/drift.dart';
import 'package:drift/native.dart';

Future<QueryExecutor> openValidationDatabase() async => NativeDatabase.memory();
