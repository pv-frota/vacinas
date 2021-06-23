import 'package:equatable/equatable.dart';

///[Entity] is an abstract class extended by models that need to be used in a [PaginatedDataTable]
///and [PaginatedListView]
abstract class Entity extends Equatable {
  ///Values utilized by the data views, first value should be icon related if useIcon is true,
  ///[PaginatedListView] only uses the first three values outside of the Expansion
  List<String>? get values;

  ///Description utilized by the data views
  List<String>? get valuesDescriptions;

  String? get iconAttributeName;
}
