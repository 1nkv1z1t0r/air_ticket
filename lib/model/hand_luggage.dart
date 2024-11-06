import 'package:json_annotation/json_annotation.dart';

part 'hand_luggage.g.dart';

@JsonSerializable()
class HardLuggage {
  @JsonKey(name: 'has_hand_luggage') final bool hasHandLuggage;
  final String? size;

  HardLuggage({required this.hasHandLuggage, required this.size});

  factory HardLuggage.fromJson(Map<String, dynamic> json) => _$HardLuggageFromJson(json);

  Map<String, dynamic> toJson() => _$HardLuggageToJson(this);
}