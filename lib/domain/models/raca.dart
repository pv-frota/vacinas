import 'package:equatable/equatable.dart';

class Raca extends Equatable {
  int id;
  String nome;

  Raca({required this.id, required this.nome});

  @override
  List<Object?> get props => [id, nome];
}
