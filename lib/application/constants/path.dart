// enum Path {
//   home,
//   error,
//   animal,
//   animal_criar,
//   animal_detalhar,
//   animal_listar,
//   animal_todos
// }

// extension FormattedPath on Path {
//   String valueFromPath({int? position}) {
//     if (position == null) {
//       return this.toString().replaceAll("Path.", "");
//     } else {
//       String cleansed = this.toString().replaceAll("Path.", "");
//       return cleansed.split("_")[position];
//     }
//   }

//   String get pathFormatted {
//     String path = this.valueFromPath();

//     if (path.contains("_")) {
//       path = path.replaceAll("_", "/");
//     }
//     return "/$path";
//   }
// }
