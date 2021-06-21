import 'package:vacinas/application/router/routes/animal_path.dart';
import 'package:vacinas/application/router/routes/error_path.dart';
import 'package:vacinas/application/router/routes/home_path.dart';

abstract class AppPath {
  String get formattedPath;
  String get value;
  AppPath handlePaths(List<String> paths);
}

AppPath parseRoute(String path) {
  final HomePath _homePath = HomePath();
  final AnimalPath _animalPath = AnimalPath();
  Uri pathUri;
  try {
    pathUri = Uri.parse(path);
  } catch (e) {
    return ErrorPath();
  }

  // Forwards '/' to our "first home", as we don't have one route for a "base" path
  if (pathUri.pathSegments.isEmpty) {
    return _homePath;
  }
  final firstSegment = pathUri.pathSegments[0];
  print("4 " + pathUri.path);

  if (firstSegment == _homePath.value) {
    return HomePath();
  } else if (firstSegment == _animalPath.value) {
    return _animalPath.handlePaths(pathUri.pathSegments);
  } else {
    return ErrorPath();
  }
}
