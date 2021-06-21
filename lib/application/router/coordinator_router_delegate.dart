import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vacinas/application/constants/path.dart';
import 'package:vacinas/application/router/routes/app_path.dart';
import 'package:vacinas/application/router/routes_coordinator.dart';

/// Core class to glue our [RoutesCoordinator] to the [Router] ecosystem, in this case, the [RouterDelegate]
///
/// This delegate essentially connects our [RoutesCoordinator] implementation to the lifecycle of [Router], meaning that
/// we can intermediate all the [Router]/[Navigator] configuration through a single core class, the [RoutesCoordinator].
///
/// See also:
///   - [RoutesCoordinator], where all the heavy navigation management is handled;
///   - `CoordinatorInformationParser`, which provides a type-safe way to parse [Router] locations.
class CoordinatorRouterDelegate extends RouterDelegate<AppPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppPath> {
  CoordinatorRouterDelegate(RoutesCoordinator coordinator)
      : _coordinator = coordinator {
    // Pass along any updates from the RouterDelegate to our coordinator, so we can keep things synchronized
    //
    // We also can't use providers (we have to store the coordinator and attach a manual listener) because we must use
    // it in methods other than build, like in `currentConfiguration` and `setNewRoutePath` overrides.
    _coordinator.addListener(notifyListeners);
  }

  final RoutesCoordinator _coordinator;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _coordinator.navigatorKey;

  @override
  AppPath? get currentConfiguration => _coordinator.currentPath;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: _coordinator.pages,
    );
  }

  @override
  Future<void> setInitialRoutePath(AppPath configuration) {
    print("initial route: " + configuration.formattedPath);
    return super.setInitialRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(AppPath configuration) =>
      SynchronousFuture(_coordinator.setNewRoutePath(configuration));

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }

    final routePage = route.settings;

    // Can't forget to notify the RoutesCoordinator that the page was popped
    if (routePage is Page) {
      _coordinator.didPop(routePage);
    } else {
      throw Exception(
        'RouteSettings shoul be a subtype of `Page` - received type: ${routePage.runtimeType}',
      );
    }

    return true;
  }
}
