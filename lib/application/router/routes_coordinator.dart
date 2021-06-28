// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vacinas/application/constants/path.dart';
// import 'package:vacinas/application/pages/ErrorPage.dart';
// import 'package:vacinas/application/pages/manipulate_animal.dart';
// import 'package:vacinas/application/pages/true_home_page.dart';
// import 'package:vacinas/application/router/routes/animal_path.dart';
// import 'package:vacinas/application/router/routes/app_path.dart';
// import 'package:vacinas/application/router/routes/error_path.dart';
// import 'package:vacinas/application/router/routes/home_path.dart';

// final coordinatorProvider = Provider<RoutesCoordinator>(
//   (_) => RoutesCoordinator(navigatorKey: GlobalKey<NavigatorState>()),
// );

// RoutesCoordinator readCoordinator(BuildContext context) =>
//     context.read(coordinatorProvider);

// class RoutesCoordinator extends ChangeNotifier {
//   RoutesCoordinator({required this.navigatorKey})
//       : _pages = [
//           MaterialPage<dynamic>(
//             child: ListAnimalPage(),
//             key: _homeKey,
//             name: _homeKey.value.pathFormatted,
//           ),
//         ];

//   final GlobalKey<NavigatorState> navigatorKey;

//   static const _homeKey = ValueKey(Path.home);
//   static const _animalCriarKey = ValueKey(Path.animal_criar);
//   static const _errorKey = ValueKey(Path.error);

//   /// Descending ordered (visibles come last) stack of visible/existing pages
//   List<Page> get pages => List.unmodifiable(_pages);
//   List<Page> _pages;

//   AppPath get currentPath => parseRoute(currentRoute);

//   String get currentRoute {
//     final currentRoute = _pages.last.name;

//     return currentRoute ?? "";
//   }

//   void didPop(Page page) {
//     _pages.remove(page);
//     notifyListeners();
//   }

//   void setNewRoutePath(AppPath path) {
//     if (path is HomePath) {
//       // Any path inheriting HomePath should be considered as the root of our application, so when navigating to it, we
//       // remove any other visible pages
//       if (currentPath.formattedPath != path.formattedPath) {
//         _pages = [];

//         _addPage(ListAnimalPage(), name: _homeKey.value, customKey: _homeKey);
//       } else {
//         // Otherwise we simply remove all pages other than the matched one
//         _pages.removeRange(1, _pages.length);
//       }
//     } else if (path is AnimalPath || path is CriarAnimalPath) {
//       _addPage(ManipulateAnimalScreen(),
//           name: _animalCriarKey.value, customKey: _animalCriarKey);
//     } else {
//       _addPage(ErrorPage(), name: _errorKey.value, customKey: _errorKey);
//     }
//     notifyListeners();
//   }

//   /// Adds a new page to the top of the current stack (last in [_pages] list)
//   ///
//   /// - [isFullscreen] changes the type of navigation that this page is shown;
//   /// - [customKey] overrides the custom key for this page (which is creating a `ValueKey` from the [name] argument).
//   void _addPage(Widget widget,
//       {required Path name,
//       bool isFullscreen = true,
//       ValueKey<Path>? customKey}) {
//     final pageKey = customKey ?? ValueKey(name);

//     // Usually, there can't be multiple pages with the same key in the pages stack. If this is the case, the usage of
//     // `Key` to manage the existing pages must be reevaluated
//     final pagesWithSameKey = _pages.where((page) => page.key == pageKey);
//     if (pagesWithSameKey.isNotEmpty) {
//       throw Exception(
//         'No pages with the same keys are allowed. Page with the same key: $pagesWithSameKey',
//       );
//     }
//     //print("5 " + name.pathFormatted);
//     _pages.add(
//       MaterialPage<dynamic>(
//           child: widget,
//           key: pageKey,
//           name: name.pathFormatted,
//           fullscreenDialog: isFullscreen),
//     );
//   }

//   /// Inserts a page in any position of the stack ([_pages] list)
//   // ignore: unused_element
//   void _insertPage(Widget widget, {required int index, required String name}) {
//     _pages.insert(
//       index,
//       MaterialPage<dynamic>(child: widget, key: ValueKey(name), name: name),
//     );
//   }

//   void pop() {
//     if (_pages.isNotEmpty) {
//       _pages.removeLast();
//       notifyListeners();
//     }
//   }

//   void navigateTo({required Path pagePath}) {
//     switch (pagePath) {
//       case Path.home:
//         setNewRoutePath(HomePath());
//         break;
//       case Path.animal:
//         setNewRoutePath(CriarAnimalPath());
//         break;
//       case Path.animal_criar:
//         setNewRoutePath(CriarAnimalPath());
//         break;
//       default:
//         setNewRoutePath(ErrorPath());
//     }
//   }
// }
