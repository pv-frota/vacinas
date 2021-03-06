import 'package:meta/meta.dart';

// This file gives us a - somewhat - more type-safe usage of images assets
// All raw images paths belong here and must be only accessed through this file.

const _iconRoot = 'assets/icons';

@visibleForTesting
enum IconKey {
  // icons
  dog,
  cat,
  vaccine,
  list
}

extension IconKeyPath on IconKey {
  @visibleForTesting
  String get path {
    switch (this) {
      case IconKey.cat:
        return "$_iconRoot/cat.png";
      case IconKey.dog:
        return "$_iconRoot/dog.png";
      case IconKey.vaccine:
        return "$_iconRoot/vaccine.png";
      case IconKey.list:
        return "$_iconRoot/list.png";
    }
  }
}

final catIcon = IconKey.cat.path;
final dogIcon = IconKey.dog.path;
final vaccineicon = IconKey.vaccine.path;
final listIcon = IconKey.list.path;
