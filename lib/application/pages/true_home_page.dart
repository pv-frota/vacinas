import 'package:flutter/material.dart';
import 'package:vacinas/application/pages/HomePage.dart';
import 'package:vacinas/application/pages/manipulate_animal.dart';
import 'package:vacinas/application/pages/utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 3 : 5,
              child: ListAnimalScreen(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 2 : 4,
              child: ManipulateAnimalScreen(),
            ),
          ],
        ),
        mobile: ListAnimalScreen(),
        tablet: ListAnimalScreen(),
      ),
    );
  }
}
