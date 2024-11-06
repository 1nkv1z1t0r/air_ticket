import 'package:air_ticket/model/model.dart';

abstract class Api {
  Future<Offers> getOffers();
  Future<TicketsOffers> getTicketsOffers();
  Future<Tickets> getTickets();
}
