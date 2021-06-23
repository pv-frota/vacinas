import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vacinas/domain/models/animal.dart';
import 'package:vacinas/domain/services/animal_services.dart';
import 'package:vacinas/main.dart';

final manipulateAnimalController =
    StateNotifierProvider<ManipulateAnimalController>((ref) {
  return ManipulateAnimalControllerImpl(ref.read(animalServices));
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
}

class ManipulateAnimalControllerImpl extends ManipulateAnimalController {
  final AnimalServices _services;

  ManipulateAnimalControllerImpl(this._services)
      : super(ManipulateAnimalState());

  @override
  void clearFields() {
    // TODO: implement clearFields
  }

  @override
  Future<void> saveAnimal() async {
    print("called");
  }

  @override
  void selectAnimal(Animal a) {
    print(a);
    super.nomeController.text = a.nome;
    super.donoController.text = a.dono;
    super.telefoneController.text = a.telefone;
    super.dataController.text = a.nascimento.toString();
    super.dropdownState.currentState!.didChange(a.tipo);
    state = ManipulateAnimalState(
        id: a.id,
        nome: a.nome,
        tipo: a.tipo,
        dono: a.dono,
        nascimento: a.nascimento,
        telefone: a.telefone);
  }
}

// ignore: must_be_immutable
class ManipulateAnimalState extends Equatable {
  int? id;
  String? nome;
  String? dono;
  String? telefone;
  String? tipo;
  int? nascimento;

  ManipulateAnimalState(
      {this.id,
      this.nome,
      this.dono,
      this.nascimento,
      this.telefone,
      this.tipo});

  @override
  List<Object?> get props => [];
}
