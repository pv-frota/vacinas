import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vacinas/application/widgets/custom_paginated_data_table.dart';
import 'package:vacinas/domain/models/animal.dart';
import 'package:vacinas/domain/services/animal_services.dart';
import 'package:vacinas/main.dart';

final homeController = StateNotifierProvider<HomeController>((ref) {
  return HomeControllerImpl(ref.read(animalServices));
});

abstract class HomeController extends StateNotifier<HomeState> {
  HomeController(HomeState state) : super(state);

  Future<void> getAllAnimal();
}

class HomeControllerImpl extends HomeController {
  HomeControllerImpl(this._services) : super(LoadingHomeState()) {
    getAllAnimal();
  }

  final AnimalServices _services;

  @override
  Future<void> getAllAnimal() async {
    if (!(state is LoadingHomeState)) {
      state = LoadingHomeState();
    }
    List<Animal> animalList = await _services.getAllAnimal();
    state = LoadedHomeState(
        dataSource: DataTableSourceIplm(dataSource: animalList));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  LoadedHomeState({required this.dataSource});

  final DataTableSourceIplm dataSource;
}
