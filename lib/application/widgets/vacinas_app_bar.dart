import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:vacinas/application/constants/icons.dart';
import 'package:vacinas/application/pages/utils/responsive.dart';

class VacinasAppBar extends StatelessWidget with PreferredSizeWidget {
  const VacinasAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: !Responsive.isDesktop(context)
            ? null
            : () => Beamer.of(context).beamToNamed("/home"),
        child: Row(
          children: [
            Image.asset(
              vaccineicon,
              height: kToolbarHeight * 0.75,
            ),
            SizedBox(width: 5),
            Text("Vacinas")
          ],
        ),
      ),
      actions: !Responsive.isDesktop(context)
          ? null
          : [
              IconButton(
                  onPressed: () => Beamer.of(context).beamToNamed("/animal"),
                  icon: Image.asset(listIcon))
            ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
