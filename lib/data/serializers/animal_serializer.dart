import 'package:vacinas/data/serializers/raca_serializer.dart';
import 'package:vacinas/data/serializers/serializer.dart';
import 'package:vacinas/data/serializers/vacina_serializer.dart';
import 'package:vacinas/domain/models/animal.dart';
import 'package:vacinas/domain/models/raca.dart';

class AnimalKeys {
  static const id = 'id';
  static const nome = 'nome';
  static const dono = 'dono';
  static const telefone = 'telefone';
  static const tipo = 'tipo';
  static const nascimento = 'nascimento';
  static const raca = 'raca';
  static const vacinaList = 'vacinaList';
}

class AnimalSerializer implements Serializer<Animal, Map<String, dynamic>> {
  @override
  Animal from(Map<String, dynamic> json) {
    final id = json[AnimalKeys.id];
    final nome = json[AnimalKeys.nome];
    final dono = json[AnimalKeys.dono];
    final telefone = json[AnimalKeys.telefone];
    final tipo = json[AnimalKeys.tipo];
    final nascimento = json[AnimalKeys.nascimento];
    final raca = json[AnimalKeys.raca];
    final vacinaList = json[AnimalKeys.vacinaList];
    return Animal(
        id: id ?? 0,
        nome: nome ?? "",
        dono: dono ?? "",
        telefone: telefone ?? "",
        tipo: tipo ?? "",
        nascimento: nascimento ?? 0,
        raca: RacaSerializer().from(raca),
        vacinaList: VacinaSerializer().fromList(vacinaList ?? []));
  }

  List<Animal> fromList(List json) {
    List<Animal> list = json.map((animal) => from(animal)).toList();
    return list;
  }

  @override
  Map<String, dynamic> to(Animal animal) => <String, dynamic>{
        AnimalKeys.id: animal.id,
        AnimalKeys.nome: animal.nome,
        AnimalKeys.dono: animal.dono,
        AnimalKeys.telefone: animal.telefone,
        AnimalKeys.nascimento: animal.nascimento,
        AnimalKeys.tipo: animal.tipo,
        AnimalKeys.raca: animal.raca,
        AnimalKeys.vacinaList: animal.vacinaList,
      };
}
