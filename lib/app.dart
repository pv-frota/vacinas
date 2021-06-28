import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vacinas/application/pages/animal/list_animal.dart';
import 'package:vacinas/application/pages/animal/manipulate_animal.dart';
import 'package:vacinas/application/pages/animal/responsive/list_animal_page.dart';
import 'package:vacinas/application/pages/home_page.dart';
import 'package:vacinas/application/pages/utils/scaffold_message.dart';
import 'package:vacinas/application/theme/theme_controller.dart';
import 'package:vacinas/application/widgets/default_scaffold_wrapper.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final routerDelegate = BeamerDelegate(
      initialPath: '/home',
      locationBuilder: SimpleLocationBuilder(
        routes: {
          '/home': (context, state) => BeamPage(
              key: ValueKey("inicio"),
              title: "Inicio - Vacinas",
              child: DefaultScaffoldWrapper(child: HomePage())),
          '/animal': (context, state) => BeamPage(
              key: ValueKey("todos1"),
              title: "Animais - Vacinas",
              child: DefaultScaffoldWrapper(child: ListAnimalPage())),
          '/animal/todos': (context, state) => BeamPage(
              key: ValueKey("todos2"),
              title: "Animais - Vacinas",
              child: DefaultScaffoldWrapper(child: ListAnimalScreen())),
          '/animal/novo': (context, state) => BeamPage(
                key: ValueKey("novo"),
                title: "Novo Animal - Vacinas",
                child: DefaultScaffoldWrapper(child: ManipulateAnimalScreen()),
              ),
          '/animal/editar/:animalId': (context, state) {
            final id = state.pathParameters['animalId'];
            return BeamPage(
                key: ValueKey('editar-$id'),
                title: "Editar Animal - Vacinas",
                child: DefaultScaffoldWrapper(
                    child: ManipulateAnimalScreen(selectedId: int.parse(id!))));
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
