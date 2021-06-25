import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:vacinas/data/gateways/local/database_transaction_handler.dart';
import 'package:vacinas/data/gateways/local/sembast_database.dart';
import 'package:vacinas/data/gateways/local/sembast.dart' as sembast;
import 'package:vacinas/data/gateways/remote/web_request_handler.dart';
import 'package:vacinas/data/repositories/animal_repository.dart';
import 'package:vacinas/domain/services/animal_services.dart';

class AppState {
  static Future<AppState> initializeDependencies() async {
    Database? db;
    SembastDatabaseImpl? dbRepo;
    DatabaseTransactionHandlerImpl? dbTransaction;

    // Gateways
    if (!kIsWeb) db = await sembast.openDatabase();
    if (db != null) dbRepo = SembastDatabaseImpl(db);
    if (dbRepo != null) dbTransaction = DatabaseTransactionHandlerImpl(dbRepo);
    final animalWeb = GenericWebRequestImpl("animal");

    // Repositories
    final animalRepo = AnimalRepositoryImpl(animalWeb);

    // Services
    final animalServices = AnimalServicesImpl(animalRepository: animalRepo);

    return AppState(animalServices: animalServices);
  }

  const AppState({
    required this.animalServices,
  });

  final AnimalServices animalServices;
}

final animalServices = Provider<AnimalServices>((_) {
  throw UnimplementedError('AnimalServices Provider must be overridden');
});
