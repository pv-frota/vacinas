import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vacinas/application/controllers/manipulate_animal_controller.dart';

// ignore: must_be_immutable
class ManipulateAnimalScreen extends HookWidget {
  ManipulateAnimalScreen({Key? key, this.selectedId}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _phonePattern = RegExp('9[1-9][0-9]{3}[0-9]{4}');

  int? selectedId;

  @override
  Widget build(BuildContext context) {
    final state = useProvider(manipulateAnimalController.state);
    final controller = useProvider(manipulateAnimalController);
    if (selectedId != null) {
      controller.selectPathAnimal(selectedId!);
    }
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Text("Create/Edit animal"),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nomeController,
                      onChanged: (value) => state.animal.nome = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please inform a name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Animal name"),
                    ),
                    TextFormField(
                      controller: controller.donoController,
                      onChanged: (value) => state.animal.dono = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please inform a owner";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Owner name"),
                    ),
                    TextFormField(
                      controller: controller.telefoneController,
                      maxLength: 9,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => state.animal.telefone = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please inform a phone number";
                        } else if (!_phonePattern.hasMatch(value)) {
                          return "Please inform a valid phone number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Phone number", hintText: "_________"),
                    ),
                    DropdownButtonFormField<String>(
                      key: controller.dropdownState,
                      value: state.animal.tipo,
                      items: ["", "C", "G"].map((i) {
                        return DropdownMenuItem<String>(
                            value: i,
                            child: i == ""
                                ? Text("Select an animal species")
                                : Text(
                                    handleTipo(i),
                                  ));
                      }).toList(),
                      onChanged: (value) => state.animal.tipo = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please inform a animal species";
                        }
                      },
                    ),
                    TextFormField(
                      controller: controller.dataController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please inform a birth date";
                        }
                      },
                      decoration:
                          InputDecoration(labelText: "Animal birth date"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.saveAnimal();
                          }
                        },
                        child: Text("Save"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String handleTipo(String tipo) {
    if (tipo == "C") {
      return "Cachorro";
    } else {
      return "Gato";
    }
  }
}
