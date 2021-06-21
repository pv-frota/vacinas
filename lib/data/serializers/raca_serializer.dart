import 'package:vacinas/data/serializers/serializer.dart';
import 'package:vacinas/domain/models/raca.dart';

class RacaKeys {
  static const id = 'id';
  static const nome = 'nome';
}

class RacaSerializer implements Serializer<Raca, Map<String, dynamic>> {
  @override
  Raca from(Map<String, dynamic> json) {
    final id = json[RacaKeys.id];
    final nome = json[RacaKeys.nome];
    return Raca(
      id: id ?? 0,
      nome: nome ?? "",
    );
  }

  List<Raca> fromList(List json) {
    List<Raca> list = json.map((raca) => from(raca)).toList();
    return list;
  }

  @override
  Map<String, dynamic> to(Raca raca) => <String, dynamic>{
        RacaKeys.id: raca.id,
        RacaKeys.nome: raca.nome,
      };
}
