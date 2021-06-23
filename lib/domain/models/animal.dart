import 'package:vacinas/domain/models/entity.dart';
import 'package:vacinas/domain/models/raca.dart';
import 'package:vacinas/domain/models/vacina.dart';

class Animal extends Entity {
  int id;
  String nome;
  String dono;
  String telefone;
  String tipo;
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
      required this.tipo,
      required this.vacinaList});

  @override
  List<Object?> get props =>
      [id, nome, dono, telefone, tipo, nascimento, raca, vacinaList];

  @override
  List<String>? get values => [
        this.id.toString(),
        this.nome,
        this.raca.nome,
        this.tipo,
        this.telefone,
        this.nascimento.toString(),
      ];

  @override
  List<String>? get valuesDescriptions =>
      ["Id", "Nome", "Raça", "Tipo", "Nascimento", "Telefone"];

  @override
  // TODO: implement iconAttributeName
  String? get iconAttributeName => "Tipo";
}
