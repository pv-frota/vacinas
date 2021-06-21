import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

const _schemaVersion = 1;
const _dbName = 'memo_sembast.db';

/// Opens this application's [Database], creating a new one if nonexistent
Future<Database> openDatabase() async {
  if (kIsWeb) {
    var store = intMapStoreFactory.store();
    var factory = databaseFactoryWeb;

    return factory.openDatabase(_dbName,
        version: _schemaVersion, onVersionChanged: applyMigrations);
  } else {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);

    final dbPath = path.join(dir.path, _dbName);

    return databaseFactoryIo.openDatabase(dbPath,
        version: _schemaVersion, onVersionChanged: applyMigrations);
  }
  // Make sure that the application documents directory exists
}

@visibleForTesting
Future<void> applyMigrations(
    Database db, int oldVersion, int newVersion) async {
  // Call the necessary migrations in order
}

//
// Migrations
//

// Example:
// Future<void> migrateToVersion2(Database db) async {
//   final store = stringMapStoreFactory.store('storeThatNeedsMigration');
//   final updatableItemsFinder = Finder(filter: Filter.equals('myUpdatedField', 1));
//   await store.update(db, { 'myUpdatedField': 2 }, finder: updatableItemsFinder);
// }
