import 'package:vacinas/data/serializers/serializer.dart';
import 'package:vacinas/domain/models/vacina.dart';

class VacinaKeys {
  static const id = 'id';
  static const nome = 'nome';
  static const data = 'dono';
}

class VacinaSerializer implements Serializer<Vacina, Map<String, dynamic>> {
  @override
  Vacina from(Map<String, dynamic> json) {
    final id = json[VacinaKeys.id];
    final nome = json[VacinaKeys.nome];
    final data = json[VacinaKeys.data];

    return Vacina(
      id: id ?? 0,
      nome: nome ?? "",
      data: data ?? 0,
    );
  }

  List<Vacina> fromList(List json) {
    List<Vacina> list = json.map((vacina) => from(vacina)).toList();
    return list;
  }

  @override
  Map<String, dynamic> to(Vacina vacina) => <String, dynamic>{
        VacinaKeys.id: vacina.id,
        VacinaKeys.nome: vacina.nome,
        VacinaKeys.data: vacina.data,
      };
}
