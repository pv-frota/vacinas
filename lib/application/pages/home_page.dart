import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width,
            color: Colors.cyan[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vacinas",
                  style: TextStyle(fontSize: 52),
                ),
                Text(
                  "Sistema de Gerenciamento de Vacinas de Animais",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.025,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Grid("Lista de animais",
          //         "É possivel ver uma listagem de animais neste sistema"),
          //     Grid("CRUD de animais",
          //         "é possível adicionar, ler, atualizar e excluir animais registrados no sistema"),
          //     Grid("CRUD de raças",
          //         "é possível adicionar, ler, atualizar e excluir raças registrados no sistema"),
          //   ],
          // )
        ],
      ),
    );
  }
}

// // Text("Lista de animais")
// // Text("É possivel ver uma listagem de animais neste sistema")
// class Grid extends StatelessWidget {
//   const Grid(this.title, this.subtitle, {Key? key}) : super(key: key);

//   final String title;
//   final String subtitle;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.15,
//       width: MediaQuery.of(context).size.width * 0.20,
//       margin: const EdgeInsets.all(4.0),
//       child: Material(
//         type: MaterialType.card,
//         color: Colors.deepPurple,
//         elevation: 1.0,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4.0)),
//         ),
//         clipBehavior: Clip.none,
//         child: ListTile(
//           title: FittedBox(
//             fit: BoxFit.contain,
//             child: Text(
//               this.title,
//               style: TextStyle(fontSize: 35),
//             ),
//           ),
//           subtitle: FittedBox(
//               fit: BoxFit.contain,
//               child: Text(this.subtitle,
//                   textAlign: TextAlign.justify,
//                   style: TextStyle(fontSize: 25))),
//         ),
//       ),
//     );
//     // return Container(
//     //   width: MediaQuery.of(context).size.width * 0.20,
//     //   child: Card(

//     //     color: Colors.deepPurple,
//     //     child:
//     //   ),
//     // );
//   }
// }
