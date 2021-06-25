import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vacinas/application/pages/list_animal.dart';
import 'package:vacinas/application/pages/manipulate_animal.dart';
import 'package:vacinas/application/pages/true_home_page.dart';
import 'package:vacinas/application/pages/utils/scaffold_message.dart';
import 'package:vacinas/application/theme/theme_controller.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final routerDelegate = BeamerDelegate(
      initialPath: '/home',
      locationBuilder: SimpleLocationBuilder(
        routes: {
          '/home': (context, state) => HomeScreen(),
          '/animal': (context, state) => ManipulateAnimalScreen(),
          '/animal/all': (context, state) => ListAnimalScreen(),
          '/animal/new': (context, state) => ManipulateAnimalScreen(),
          '/animal/edit/:animalId': (context, state) {
            final id = state.pathParameters['animalId'];
            return BeamPage(
                key: ValueKey('editar-$id'),
                title: "Editar informações do animal",
                child: ManipulateAnimalScreen(selectedId: int.parse(id!)));
          }
        },
      ),
    );

    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      scaffoldMessengerKey: useScaffoldMessenger(),
      title: 'Vacinas',
      debugShowCheckedModeBanner: false,
      theme: useThemeController().currentThemeData(context),
    );
  }
}
