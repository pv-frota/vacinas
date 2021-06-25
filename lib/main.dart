import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vacinas/app.dart';
import 'package:vacinas/domain/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppState appState = await AppState.initializeDependencies();
  runApp(ProviderScope(overrides: [
    animalServices.overrideWithValue(appState.animalServices),
  ], child: App()));
}
