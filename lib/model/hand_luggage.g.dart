// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hand_luggage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HardLuggage _$HardLuggageFromJson(Map<String, dynamic> json) => HardLuggage(
      hasHandLuggage: json['has_hand_luggage'] as bool,
      size: json['size'] as String?,
    );

Map<String, dynamic> _$HardLuggageToJson(HardLuggage instance) =>
    <String, dynamic>{
      'has_hand_luggage': instance.hasHandLuggage,
      'size': instance.size,
    };
