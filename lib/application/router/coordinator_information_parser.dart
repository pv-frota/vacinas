import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vacinas/application/constants/path.dart';
import 'package:vacinas/application/router/routes/app_path.dart';
import 'package:vacinas/application/router/routes/animal_path.dart';
import 'package:vacinas/application/router/routes/error_path.dart';
import 'package:vacinas/application/router/routes/home_path.dart';

class CoordinatorInformationParser extends RouteInformationParser<AppPath> {
  final HomePath _homePath = HomePath();
  final AnimalPath _animalPath = AnimalPath();

  List<String> pathList = [];

  @override
  Future<AppPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    print("3" + routeInformation.location.toString());
    return SynchronousFuture(parseRoute(routeInformation.location ?? ""));
  }

  @override
  RouteInformation? restoreRouteInformation(AppPath path) {
    if (pathList.isEmpty) {
      for (Path p in Path.values) {
        pathList.add(p.pathFormatted);
      }
    }
    print("2 " + path.formattedPath);
    if (pathList.contains(path.formattedPath)) {
      return RouteInformation(location: path.formattedPath);
    } else {
      return RouteInformation(location: Path.error.pathFormatted);
    }
  }
}
