import 'package:equatable/equatable.dart';

///[Entity] is an abstract class extended by models that need to be used in a [PaginatedDataTable],
///it is used in [DataTableImpl] that is needed by [PaginatedDataTable]
abstract class Entity extends Equatable {
  int get key;
  String get name;
  String? get optional1;
  String? get optional2;
  String? get optional3;
}
