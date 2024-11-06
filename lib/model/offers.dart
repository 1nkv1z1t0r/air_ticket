import 'package:air_ticket/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offers.g.dart';

@JsonSerializable()
class Offers {
  final List<Offer> offers;

  Offers({required this.offers});

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);
}
