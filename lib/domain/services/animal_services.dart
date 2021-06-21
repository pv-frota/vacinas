import 'package:vacinas/data/repositories/animal_repository.dart';
import 'package:vacinas/domain/models/animal.dart';

abstract class AnimalServices {
  // Future<Animal> getAnimalById(int id);
  Future<List<Animal>> getAllAnimal();
}

class AnimalServicesImpl implements AnimalServices {
  final AnimalRepository animalRepository;

  AnimalServicesImpl({required this.animalRepository});

  @override
  Future<List<Animal>> getAllAnimal() {
    return animalRepository.getAllAnimal();
  }
}
