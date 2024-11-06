part of 'search_tickets_bloc.dart';

class SearchTicketsState extends Equatable {
  final List<TicketOffer>? ticketsOffers;
  final DateTime? returnTicketDate;
  final DateTime ticketDate;

  const SearchTicketsState({required this.ticketsOffers, required this.ticketDate, required this.returnTicketDate,});

  @override
  List<Object?> get props => [ticketsOffers,ticketDate,returnTicketDate];
}

