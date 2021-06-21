import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vacinas/application/constants/path.dart';
import 'package:vacinas/application/router/routes_coordinator.dart';

class ErrorPage extends HookWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Error has occurred"),
          ElevatedButton(
              onPressed: () =>
                  readCoordinator(context).navigateTo(pagePath: Path.home),
              child: Text("Retornar ao inicio"))
        ],
      ),
    );
  }
}
