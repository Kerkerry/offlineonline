import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:offlineapp/core/resources/data_state.dart';
import 'package:offlineapp/features/home/data/model/products_model.dart';
import 'package:offlineapp/features/home/presentation/bloc/home_status.dart';
import 'package:offlineapp/features/home/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  HomeBloc(this._homeRepository)
      : super(HomeState(homeProductsStatus: HomeProductsStatusInit())) {
    on<HomeCallProductsEvent>(_homeCallProductsHandler);
  }

  FutureOr<void> _homeCallProductsHandler(
      HomeCallProductsEvent event, Emitter<HomeState> emit) async {
    // Make a state to loading
    emit(state.copyWith(homeProductsStatus: HomeProductsStatusLoading()));
    // Get DataSuccess or DataFailed from the repository
    final DataState dataState = await _homeRepository.fetchProducts();

    if (dataState is DataSuccess) {
      emit(state.copyWith(
          homeProductsStatus: HomeProductsStatusComplete(
              products: dataState.data as ProductsModel)));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
          homeProductsStatus:
              HomeProductsStatusError(errorMsg: dataState.error as String)));
    }
  }
}



// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomeInitial()) {
//     on<HomeEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
