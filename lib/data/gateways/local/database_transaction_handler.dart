import 'package:vacinas/data/gateways/local/sembast_database.dart';

abstract class DatabaseTransactionHandler {
  /// Handles all changes made inside [run] as a single atomic operation
  Future<void> runInTransaction(Future<void> Function() run);
}

class DatabaseTransactionHandlerImpl implements DatabaseTransactionHandler {
  DatabaseTransactionHandlerImpl(this._db);

  final SembastDatabase _db;

  @override
  Future<void> runInTransaction(Future<void> Function() run) =>
      _db.runInTransaction(run);
}
