part of 'search_tickets_bloc.dart';

abstract class SearchTicketsEvent{}

class SearchTicketsTicketsOffersLoadingStarted extends SearchTicketsEvent {}
class ReturnTicketSelectDateTappedEvent extends SearchTicketsEvent {}
class TicketSelectDateTappedEvent extends SearchTicketsEvent {}
