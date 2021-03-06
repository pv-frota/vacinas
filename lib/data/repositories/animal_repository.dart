import 'package:vacinas/data/gateways/remote/web_request_handler.dart';
import 'package:vacinas/data/serializers/animal_serializer.dart';
import 'package:vacinas/domain/models/animal.dart';

abstract class AnimalRepository {
  ///Get request that queries by [id] and returns `Animal`
  Future<Animal> getAnimalById(int id);

  ///Get request that returns a list of all `Animal`s
  Future<List<Animal>> getAllAnimal();
  Future<Animal> saveAnimal(Animal animal);
}

class AnimalRepositoryImpl implements AnimalRepository {
  final AnimalSerializer _animalSerializer = AnimalSerializer();
  final GenericWebRequestImpl _animalRequests;

  AnimalRepositoryImpl(this._animalRequests);

  @override
  Future<Animal> saveAnimal(Animal animal) async {
    Map<String, dynamic> asJson = _animalSerializer.to(animal);
    dynamic map = await _animalRequests.save(asJson);
    return _animalSerializer.from(map);
  }

  @override
  Future<Animal> getAnimalById(int id) async {
    dynamic map = await _animalRequests.getById(id);
    return _animalSerializer.from(map);
  }

  @override
  Future<List<Animal>> getAllAnimal() async {
    List map = await _animalRequests.getAll();
    return _animalSerializer.fromList(map);
  }
}
