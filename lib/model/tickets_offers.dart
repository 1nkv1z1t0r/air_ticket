import 'package:air_ticket/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tickets_offers.g.dart';

@JsonSerializable()
class TicketsOffers {
  final List<TicketOffer> tickets_offers;

  TicketsOffers({required this.tickets_offers});

  factory TicketsOffers.fromJson(Map<String, dynamic> json) =>
      _$TicketsOffersFromJson(json);
}
