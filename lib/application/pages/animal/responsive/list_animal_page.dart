import 'package:flutter/material.dart';
import 'package:vacinas/application/pages/animal/desktop/list_manipulate_desktop.dart';
import 'package:vacinas/application/pages/animal/list_animal.dart';
import 'package:vacinas/application/pages/utils/responsive.dart';

class ListAnimalPage extends StatelessWidget {
  const ListAnimalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Responsive(
      desktop: ListManipulateDesktop(_size),
      mobile: ListAnimalScreen(),
      tablet: ListAnimalScreen(),
    );
  }
}
