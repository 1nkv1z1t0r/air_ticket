import 'dart:async';

import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/repository/data_repository.dart';
import 'package:air_ticket/repository/local_storage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required DataRepository dataRepository,
    required LocalStorageRepository localStorageRepository,
  })  : _dataRepository = dataRepository,
        _localStorageRepository = localStorageRepository,
        super(HomeState(
            offers: null, departure: localStorageRepository.getDeparture())) {
    on<HomeOffersLoadingStarted>(_onHomeOffersLoadingStarted);
    on<HomeDepartureChanged>(_onHomeDepartureChanged);

    _removeDepartureListener =
        _localStorageRepository.listenToDepartureChanges((departure) {
      add(HomeDepartureChanged(departure));
    });
  }

  final DataRepository _dataRepository;
  final LocalStorageRepository _localStorageRepository;

  late final void Function() _removeDepartureListener;

  FutureOr<void> _onHomeOffersLoadingStarted(
    HomeOffersLoadingStarted event,
    Emitter<HomeState> emit,
  ) async {
    final offers = await _dataRepository.getOffers();
    emit(HomeState(offers: offers, departure: state.departure));
  }

  FutureOr<void> _onHomeDepartureChanged(
    HomeDepartureChanged event,
    Emitter<HomeState> emit,
  ) async {
    if (event.departure == state.departure) return;

    _localStorageRepository.setDeparture(event.departure);
    emit(HomeState(offers: state.offers, departure: event.departure));
  }

  @override
  Future<void> close() {
    _removeDepartureListener();

    return super.close();
  }
}
