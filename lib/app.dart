import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layoutr/common_layout.dart';
import 'package:vacinas/application/pages/SplashPage.dart';
import 'package:vacinas/application/pages/utils/scaffold_message.dart';
import 'package:vacinas/application/router/coordinator_information_parser.dart';
import 'package:vacinas/application/router/coordinator_router_delegate.dart';
import 'package:vacinas/application/router/routes_coordinator.dart';
import 'package:vacinas/application/theme/theme_controller.dart';
import 'package:vacinas/main.dart';

/// "Pre-load" root widget for the application
///
/// This widget is a wrapper to provide (and load) an instance of [AppState], while showing a splash screen while it's
/// loading for any external/internal dependencies.
class AppRoot extends StatelessWidget {
  const AppRoot(this.vm);
  final AppVM vm;

  @override
  Widget build(BuildContext context) {
    final bundle = DefaultAssetBundle.of(context);
    vm.loadDependencies(bundle);

    return ValueListenableBuilder<AsyncValue<AppState>>(
      valueListenable: vm,
      builder: (context, value, child) {
        return value.maybeWhen(
          data: (state) {
            return CommonLayoutWidget(
              spacings: RawSpacings(2, 4, 8, 12, 16, 24, 32, 40, 48),
              child: ProviderScope(
                // Override all `Provider` and `ScopedProvider` that are late-initialized
                overrides: [
                  animalServices.overrideWithValue(state.animalServices),
                ],
                child: _LoadedAppRoot(),
              ),
            );
          },
          orElse: () => const MaterialApp(home: SplashPage()),
        );
      },
    );
  }
}

/// Loaded root widget for the application
///
/// After [AppRoot] is done with the loading, [_LoadedAppRoot] takes place (of the [SplashPage]) as the root of our
/// application (and have all late-initialized providers available to it).
class _LoadedAppRoot extends StatefulHookWidget {
  @override
  _LoadedAppRootState createState() => _LoadedAppRootState();
}

class _LoadedAppRootState extends State<_LoadedAppRoot> {
  PlatformRouteInformationProvider? _routeInformationParser;

  @override
  Widget build(BuildContext context) {
    final coordinator = readCoordinator(context);

    // Must keep stored the `PlatformRouteInformationProvider`, otherwise when this widget rebuilds (for any reason),
    // the current route will be reset to our "root". Not sure if this is the best approach, but this new Router API
    // sure is confusing.
    _routeInformationParser ??= PlatformRouteInformationProvider(
      initialRouteInformation:
          RouteInformation(location: coordinator.currentRoute),
    );

    return MaterialApp.router(
      scaffoldMessengerKey: useScaffoldMessenger(),
      title: 'Vacinas',
      debugShowCheckedModeBanner: false,
      theme: useThemeController().currentThemeData(context),
      routerDelegate: CoordinatorRouterDelegate(coordinator),
      routeInformationParser: CoordinatorInformationParser(),
      routeInformationProvider: _routeInformationParser,
    );
  }
}
