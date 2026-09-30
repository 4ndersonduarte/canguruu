import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

QueryExecutor openLocalDatabase() => driftDatabase(
  name: 'canguruu_finance',
  native: const DriftNativeOptions(
    databaseDirectory: getApplicationSupportDirectory,
  ),
  web: DriftWebOptions(
    sqlite3Wasm: Uri.parse('sqlite3.wasm'),
    driftWorker: Uri.parse('drift_worker.dart.js'),
    onResult: (result) {
      final implementation = result.chosenImplementation.name;
      if (implementation == 'inMemory' || implementation == 'unsafeIndexedDb') {
        result.resolvedExecutor.close();
        throw StateError(
          'Este navegador não oferece armazenamento local seguro. Use Chrome, Edge ou a versão instalada.',
        );
      }
    },
  ),
);
