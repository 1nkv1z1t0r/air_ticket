part of 'all_tickets_bloc.dart';

class AllTicketsState extends Equatable {
  final List<Ticket>? tickets;

  const AllTicketsState({required this.tickets});

  @override
  List<Object?> get props => [tickets];
}
