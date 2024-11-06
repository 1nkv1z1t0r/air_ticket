part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeOffersLoadingStarted extends HomeEvent {}

class HomeDepartureChanged extends HomeEvent {
  HomeDepartureChanged(this.departure);

  final String departure;
}
