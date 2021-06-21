import 'package:equatable/equatable.dart';

class Vacina extends Equatable {
  int id;
  String nome;
  int data;

  Vacina({required this.id, required this.nome, required this.data});

  @override
  List<Object?> get props => [id, nome, data];
}
