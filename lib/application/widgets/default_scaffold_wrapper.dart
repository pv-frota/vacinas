import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vacinas/application/constants/icons.dart';
import 'package:vacinas/application/controllers/drawer_controller.dart';
import 'package:vacinas/application/pages/utils/responsive.dart';
import 'package:vacinas/application/widgets/vacinas_app_bar.dart';

class DefaultScaffoldWrapper extends HookWidget {
  final Widget child;
  DefaultScaffoldWrapper({required this.child});
  @override
  Widget build(BuildContext context) {
    final controller = useProvider(drawerController);
    final selected = useProvider(drawerController.state);
    return Scaffold(
      appBar: VacinasAppBar(),
      drawer: Responsive.isDesktop(context)
          ? null
          : Drawer(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Image.asset(
                      vaccineicon,
                      height: kToolbarHeight * 0.75,
                    ),
                    Text("Vacinas"),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        controller.setCurrentTab(0);
                        Beamer.of(context).beamToNamed("/home");
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.home_rounded,
                            size: kToolbarHeight * 0.75,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Inicio",
                            style: TextStyle(
                                color: selected == 0
                                    ? Colors.amber
                                    : Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        controller.setCurrentTab(1);
                        Beamer.of(context).beamToNamed("/animal");
                      },
                      child: Row(
                        children: [
                          Image.asset(listIcon, height: kToolbarHeight * 0.75),
                          SizedBox(width: 5),
                          Text(
                            "Listar animais",
                            style: TextStyle(
                                color: selected == 1
                                    ? Colors.amber
                                    : Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: child,
    );
  }
}
