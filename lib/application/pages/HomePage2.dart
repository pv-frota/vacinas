import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vacinas/application/controllers/HomePageController.dart';

class HomePage2 extends HookWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(homeController.state);

    if (state is LoadingHomeState) {
      return const Center(child: CircularProgressIndicator());
    }

    final loadedState = state as LoadedHomeState;
    return Container(
      child: Text(""),
    );
  }
}
