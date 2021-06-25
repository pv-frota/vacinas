import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vacinas/application/controllers/HomePageController.dart';
import 'package:vacinas/application/controllers/manipulate_animal_controller.dart';
import 'package:vacinas/application/pages/utils/responsive.dart';
import 'package:vacinas/application/widgets/custom_paginated_data_table.dart';
import 'package:vacinas/application/widgets/custom_paginated_list_view.dart';
import 'package:vacinas/domain/models/animal.dart';

class ListAnimalScreen extends HookWidget {
  ListAnimalScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = useProvider(homeController.state);
    final controller = useProvider(homeController);
    final animalController = useProvider(manipulateAnimalController);
    //final theme = useTheme();

    if (state is LoadingHomeState) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Vacinas"),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Center(child: Consumer(
                builder: (context, watch, child) {
                  final a = watch(homeController.state);
                  return displayData(
                      a as LoadedHomeState, animalController, context);
                },
              )),
              ElevatedButton(
                  onPressed: () => controller.getAllAnimal(),
                  child: Text("Atualizar lista"))
            ],
          ),
        ),
      ),
    );
  }

  Widget displayData(LoadedHomeState state,
      ManipulateAnimalController animalController, BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return CustomPaginatedDataTable(
        data: state.animalList,
        rowsPerPage: 5,
        header: "Lista de animais",
        onTap: (index) {
          animalController.selectAnimal(state.animalList[index]);
        },
      );
    } else if (Responsive.isTablet(context)) {
      return CustomPaginatedDataTable(
        data: state.animalList,
        rowsPerPage: 5,
        header: "Lista de animais",
        onTap: (index) {
          Animal a = state.animalList.elementAt(index);
          Beamer.of(context).beamToNamed("/animal/edit/${a.id}");
        },
      );
    } else {
      return CustomPaginatedListView(
        data: state.animalList,
        itemsPerPage: 3,
        usesIcon: true,
        listName: "Lista de animais",
        onTap: (index) {
          Animal a = state.animalList.elementAt(index);
          Beamer.of(context).beamToNamed("/animal/edit/${a.id}");
        },
      );
    }
  }
}
