part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Offer>? offers;
  final String departure;

  const HomeState({required this.offers, required this.departure});

  @override
  List<Object?> get props => [offers, departure];
}
