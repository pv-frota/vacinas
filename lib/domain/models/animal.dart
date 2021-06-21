import 'package:vacinas/domain/models/entity.dart';
import 'package:vacinas/domain/models/raca.dart';
import 'package:vacinas/domain/models/vacina.dart';

class Animal extends Entity {
  int id;
  String nome;
  String dono;
  String telefone;
  String? tipo;
  int nascimento;
  Raca raca;
  List<Vacina> vacinaList;

  Animal(
      {required this.dono,
      required this.id,
      required this.nascimento,
      required this.nome,
      required this.raca,
      required this.telefone,
      this.tipo,
      required this.vacinaList});

  @override
  List<Object?> get props =>
      [id, nome, dono, telefone, tipo, nascimento, raca, vacinaList];

  @override
  int get key => this.id;

  @override
  String get name => this.nome;

  @override
  String? get optional1 => this.raca.nome;

  @override
  String? get optional2 => this.dono;
  @override
  String? get optional3 => this.telefone;
}
