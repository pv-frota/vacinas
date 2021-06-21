import 'package:vacinas/data/gateways/remote/web_request_handler.dart';
import 'package:vacinas/data/serializers/animal_serializer.dart';
import 'package:vacinas/domain/models/animal.dart';

abstract class AnimalRepository {
  ///Get request that queries by [id] and returns `Animal`
  Future<Animal> getAnimalById(int id);

  ///Get request that returns a list of all `Animal`s
  Future<List<Animal>> getAllAnimal();
}

class AnimalRepositoryImpl extends GenericWebRequestImpl
    implements AnimalRepository {
  final AnimalSerializer _animalSerializer = AnimalSerializer();

  AnimalRepositoryImpl(String path) : super(path);

  Future<Animal> getAnimalById(int id) async {
    Map<String, dynamic> map = await super.getById(id);
    return _animalSerializer.from(map);
  }

  Future<List<Animal>> getAllAnimal() async {
    List map = await super.getAll();
    return _animalSerializer.fromList(map);
  }
}
