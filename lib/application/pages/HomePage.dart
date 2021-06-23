import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vacinas/application/controllers/HomePageController.dart';
import 'package:vacinas/application/controllers/manipulate_animal_controller.dart';
import 'package:vacinas/application/widgets/custom_paginated_data_table.dart';
import 'package:vacinas/application/widgets/custom_paginated_list_view.dart';

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

    final loadedState = state as LoadedHomeState;
    final paginatedDataView = !kIsWeb
        ? CustomPaginatedDataTable(
            dataTableSource: loadedState.dataSource,
            rowsPerPage: 5,
            header: "Lista de animais",
          )
        : CustomPaginatedListView(
            data: loadedState.animalList,
            itemsPerPage: 3,
            usesIcon: true,
            listName: "Lista de animais",
            onTap: (index) {
              animalController.selectAnimal(loadedState.animalList[index]);
            },
          );

    return Scaffold(
      appBar: AppBar(
        title: Text("Vacinas"),
      ),
      body: Container(
        child: SafeArea(
          child: Expanded(
            child: Column(
              children: [
                Center(child: paginatedDataView),
                ElevatedButton(
                    onPressed: () => controller.getAllAnimal(),
                    child: Text("Atualizar lista"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
