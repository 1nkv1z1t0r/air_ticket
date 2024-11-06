// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      town: json['town'] as String,
      date: DateTime.parse(json['date'] as String),
      airport: json['airport'] as String,
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'town': instance.town,
      'date': instance.date.toIso8601String(),
      'airport': instance.airport,
    };
