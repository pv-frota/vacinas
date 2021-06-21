import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vacinas/application/controllers/HomePageController.dart';
import 'package:vacinas/application/widgets/custom_paginated_data_table.dart';
import 'package:vacinas/application/widgets/theme/themed_container.dart';

class HomePage extends HookWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = useProvider(homeController.state);
    final controller = useProvider(homeController);
    //final theme = useTheme();

    if (state is LoadingHomeState) {
      return const Center(child: CircularProgressIndicator());
    }

    final loadedState = state as LoadedHomeState;
    return Scaffold(
      appBar: AppBar(
        title: Text("Vacinas"),
      ),
      body: ThemedTopContainer(
        child: Column(
          children: [
            Center(
                child: CustomPaginatedDataTable(
              dataTableSource: loadedState.dataSource,
              rowsPerPage: 5,
              header: "Animais",
              keyColumnName: "Id",
              nameColumnName: "Nome",
              optional1ColumnName: "Raça",
              optional2ColumnName: "Dono",
              optional3ColumnName: "Telefone",
            )),
            ElevatedButton(
                onPressed: () => controller.getAllAnimal(),
                child: Text("Atualizar lista"))
          ],
        ),
      ),
    );
  }
}
