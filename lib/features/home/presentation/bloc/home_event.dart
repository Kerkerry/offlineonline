part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// For loading products
class HomeCallProductsEvent extends HomeEvent {
  const HomeCallProductsEvent();

  @override
  List<Object> get props => [];
}
