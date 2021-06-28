import 'package:flutter/material.dart';
import 'package:vacinas/application/pages/animal/list_animal.dart';
import 'package:vacinas/application/pages/animal/manipulate_animal.dart';

class ListManipulateDesktop extends StatelessWidget {
  const ListManipulateDesktop(this._size, {Key? key}) : super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        Expanded(
          flex: _size.width > 1340 ? 5 : 6,
          child: ListAnimalScreen(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        Expanded(
          flex: _size.width > 1340 ? 4 : 3,
          child: ManipulateAnimalScreen(),
        ),
        Padding(
          padding: EdgeInsets.only(right: 5),
        ),
      ],
    );
  }
}
