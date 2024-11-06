import 'package:air_ticket/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'luggage.g.dart';

@JsonSerializable()
class Luggage {
  @JsonKey(defaultValue: false) final bool has_luggage;
  final Price? price;

  Luggage({required this.has_luggage, required this.price});

  factory Luggage.fromJson(Map<String, dynamic> json) => _$LuggageFromJson(json);

  Map<String, dynamic> toJson() => _$LuggageToJson(this);
}