import 'package:air_ticket/api/api.dart';
import 'package:air_ticket/api/mock_api.dart';
import 'package:air_ticket/model/model.dart';

class DataRepository {
  final Api _api;

  DataRepository({required MockApi api}) : _api = api;

  Future<List<Offer>> getOffers() {
    return _api.getOffers().then((offers) => offers.offers);
  }

  Future<List<TicketOffer>> getTicketsOffers() {
    return  _api.getTicketsOffers().then((ticketsOffers) => ticketsOffers.tickets_offers);
  }

  Future<List<Ticket>> getTickets() {
    return _api.getTickets().then((tickets) => tickets.tickets);
  }
}