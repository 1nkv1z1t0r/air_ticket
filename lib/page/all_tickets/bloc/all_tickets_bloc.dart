import 'dart:async';

import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_tickets_event.dart';
part 'all_tickets_state.dart';

class AllTicketsBloc extends Bloc<AllTicketsEvent, AllTicketsState> {
  AllTicketsBloc({
    required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(AllTicketsState(tickets: null)) {
    on<AllTicketsTicketsLoadingStarted>(_onAllTicketsTicketsLoadingStarted);
  }

  final DataRepository _dataRepository;

  FutureOr<void> _onAllTicketsTicketsLoadingStarted(
    AllTicketsTicketsLoadingStarted event,
    Emitter<AllTicketsState> emit,
  ) async {
    final tickets = await _dataRepository.getTickets();
    emit(AllTicketsState(tickets: tickets));
  }
}
