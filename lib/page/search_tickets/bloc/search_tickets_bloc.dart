import 'dart:async';

import 'package:air_ticket/model/model.dart';
import 'package:air_ticket/repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_tickets_event.dart';

part 'search_tickets_state.dart';

class SearchTicketsBloc extends Bloc<SearchTicketsEvent, SearchTicketsState> {
  SearchTicketsBloc(
      {required DataRepository dataRepository, required BuildContext context})
      : _dataRepository = dataRepository,
        _context = context,
        super(SearchTicketsState(
            ticketsOffers: null,
            ticketDate: DateTime.now(),
            returnTicketDate: null)) {
    on<SearchTicketsTicketsOffersLoadingStarted>(
        _onAllTicketsTicketsLoadingStarted);
    on<TicketSelectDateTappedEvent>(_onTicketSelectDateTappedEvent);
    on<ReturnTicketSelectDateTappedEvent>(_onReturnTicketSelectDateTappedEvent);
  }

  final BuildContext _context;
  final DataRepository _dataRepository;

  FutureOr<void> _onAllTicketsTicketsLoadingStarted(
    SearchTicketsTicketsOffersLoadingStarted event,
    Emitter<SearchTicketsState> emit,
  ) async {
    final ticketsOffers = await _dataRepository.getTicketsOffers();
    emit(SearchTicketsState(
        ticketsOffers: ticketsOffers,
        ticketDate: state.ticketDate,
        returnTicketDate: state.returnTicketDate));
  }

  FutureOr<void> _onTicketSelectDateTappedEvent(
    TicketSelectDateTappedEvent event,
    Emitter<SearchTicketsState> emit,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: _context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    emit(SearchTicketsState(
        ticketsOffers: state.ticketsOffers,
        ticketDate: picked ?? state.ticketDate,
        returnTicketDate: state.returnTicketDate));
  }

  FutureOr<void> _onReturnTicketSelectDateTappedEvent(
    ReturnTicketSelectDateTappedEvent event,
    Emitter<SearchTicketsState> emit,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: _context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    emit(SearchTicketsState(
        ticketsOffers: state.ticketsOffers,
        ticketDate: state.ticketDate,
        returnTicketDate: picked ?? state.returnTicketDate));
  }
}
