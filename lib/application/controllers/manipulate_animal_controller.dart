import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vacinas/application/controllers/HomePageController.dart';
import 'package:vacinas/domain/models/animal.dart';
import 'package:vacinas/domain/models/raca.dart';
import 'package:vacinas/domain/services/animal_services.dart';
import 'package:vacinas/main.dart';

final manipulateAnimalController =
    StateNotifierProvider<ManipulateAnimalController>((ref) {
  return ManipulateAnimalControllerImpl(ref.read);
});

abstract class ManipulateAnimalController
    extends StateNotifier<ManipulateAnimalState> {
  ManipulateAnimalController(ManipulateAnimalState state) : super(state);

  final nomeController = TextEditingController();
  final donoController = TextEditingController();
  final telefoneController = TextEditingController();
  final dataController = TextEditingController();
  final dropdownState = GlobalKey<FormFieldState>();

  void clearFields();
  Future<void> saveAnimal();
  void selectAnimal(Animal a);
  void selectPathAnimal(int id);
}

class ManipulateAnimalControllerImpl extends ManipulateAnimalController {
  late AnimalServices _services;
  final Reader _reader;

  ManipulateAnimalControllerImpl(this._reader)
      : super(ManipulateAnimalState()) {
    _services = _reader(animalServices);
  }

  @override
  void clearFields() {
    // TODO: implement clearFields
  }

  @override
  Future<void> saveAnimal() async {
    Animal a = await _services.saveAnimal(state.animal);
    final hController = _reader(homeController);
    final hState = (_reader(homeController.state) as LoadedHomeState);
    List<Animal> animais = hState.animalList;
    if (state.animal.id != 0) {
      int index = hController.getPosition(state.animal.id);
      animais[index] = a;
    } else {
      animais.add(a);
      animais.sort((a, b) => a.id.compareTo(b.id));
    }
    hController.updateState(animais);
  }

  @override
  void selectAnimal(Animal a) {
    super.nomeController.text = a.nome;
    super.donoController.text = a.dono;
    super.telefoneController.text = a.telefone;
    super.dataController.text = a.nascimento.toString();
    super.dropdownState.currentState!.didChange(a.tipo);

    state.animal.id = a.id;
    state.animal.nome = a.nome;
    state.animal.tipo = a.tipo;
    state.animal.dono = a.dono;
    state.animal.nascimento = a.nascimento;
    state.animal.telefone = a.telefone;
  }

  @override
  void selectPathAnimal(int id) {
    List<Animal> list =
        (_reader(homeController.state) as LoadedHomeState).animalList;
    Animal a = list.firstWhere((element) => element.id == id);
    super.nomeController.text = a.nome;
    super.donoController.text = a.dono;
    super.telefoneController.text = a.telefone;
    super.dataController.text = a.nascimento.toString();
    super.dropdownState.currentState!.didChange(a.tipo);

    state.animal.id = a.id;
    state.animal.nome = a.nome;
    state.animal.tipo = a.tipo;
    state.animal.dono = a.dono;
    state.animal.nascimento = a.nascimento;
    state.animal.telefone = a.telefone;
  }
}

// ignore: must_be_immutable
class ManipulateAnimalState extends Equatable {
  Animal animal = Animal(
      id: 0,
      nome: "",
      dono: "",
      nascimento: 0,
      telefone: "",
      vacinaList: [],
      tipo: "",
      raca: Raca(id: 0, nome: ""));
  ManipulateAnimalState();

  @override
  List<Object?> get props => [];
}
