import 'package:air_ticket/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  final int id;
  final String? badge;
  final Price price;
  final String provider_name;
  final String company;
  final Place departure;
  final Place arrival;
  final bool has_transfer;
  final bool has_visa_transfer;
  final Luggage luggage;
  final HardLuggage hand_luggage;
  final bool is_returnable;
  final bool is_exchangable;

  Ticket({
    this.badge,
    required this.provider_name,
    required this.company,
    required this.departure,
    required this.arrival,
    required this.has_transfer,
    required this.has_visa_transfer,
    required this.luggage,
    required this.hand_luggage,
    required this.is_returnable,
    required this.is_exchangable,
    required this.id,
    required this.price,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
