import 'package:vacinas/application/constants/path.dart';
import 'package:vacinas/application/router/routes/app_path.dart';
import 'package:vacinas/application/router/routes/error_path.dart';

///Path responsible for animal related screens
///shouldn't be called alone but if it is, defaults to `ListarAnimalPath`
class AnimalPath extends AppPath {
  final Path basePathName = Path.animal;
  @override
  String get formattedPath => basePathName.pathFormatted;
  String get value => basePathName.valueFromPath();
  @override
  AppPath handlePaths(List<String> animalPath) {
    String multiSegmentedPath = "";

    if (animalPath.isEmpty) {
      return ListarAnimalPath();
    }

    String firstElement = animalPath.elementAt(0);
    print("->" + firstElement);
    print("->" + ListarAnimalPath.pathName.valueFromPath(position: 1));

    if (firstElement == ListarAnimalPath.pathName.valueFromPath(position: 1) ||
        firstElement == basePathName.valueFromPath()) {
      return ListarAnimalPath();
    } else if (firstElement ==
        CriarAnimalPath.pathName.valueFromPath(position: 1)) {
      return CriarAnimalPath();
    } else if (firstElement ==
        DetalharAnimalPath.pathName.valueFromPath(position: 1)) {
      int animalId = int.parse(animalPath.last);
      return DetalharAnimalPath(id: animalId);
    } else if (firstElement ==
        ListarAnimalUsuarioPath.pathName.valueFromPath(position: 1)) {
      int userId = int.parse(animalPath.last);
      return ListarAnimalUsuarioPath(id: userId);
    }

    for (String segment in animalPath) {
      if (segment == animalPath.first) {
        multiSegmentedPath += segment;
        continue;
      }
      multiSegmentedPath += "/$segment";
      switch (multiSegmentedPath) {
        //TODO create multi segmented paths
        default:
          continue;
      }
    }

    return ErrorPath();
  }
}

class DetalharAnimalPath extends AnimalPath {
  static const Path pathName = Path.animal_detalhar;

  final int id;

  DetalharAnimalPath({required this.id});
  @override
  String get formattedPath => pathName.pathFormatted + this.id.toString();
  String get value => pathName.valueFromPath();
}

class ListarAnimalPath extends AnimalPath {
  static const Path pathName = Path.animal_todos;
  @override
  String get formattedPath => pathName.pathFormatted;
  String get value => pathName.valueFromPath();
}

class ListarAnimalUsuarioPath extends AnimalPath {
  static const Path pathName = Path.animal_listar;

  final int id;

  ListarAnimalUsuarioPath({required this.id});
  @override
  String get formattedPath => pathName.pathFormatted + this.id.toString();
  String get value => pathName.valueFromPath();
}

class CriarAnimalPath extends AnimalPath {
  static const Path pathName = Path.animal_criar;
  @override
  String get formattedPath => pathName.pathFormatted;
  String get value => pathName.valueFromPath();
}
