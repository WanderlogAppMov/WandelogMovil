// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flight _$FlightFromJson(Map<String, dynamic> json) => Flight(
      flightId: (json['flightId'] as num).toInt(),
      airline: json['airline'] as String,
      departureCountry: json['departureCountry'] as String,
      arrivalCountry: json['arrivalCountry'] as String,
      price: (json['price'] as num).toDouble(),
      continent: Continent.fromJson(json['continent'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$FlightToJson(Flight instance) => <String, dynamic>{
      'flightId': instance.flightId,
      'airline': instance.airline,
      'departureCountry': instance.departureCountry,
      'arrivalCountry': instance.arrivalCountry,
      'price': instance.price,
      'continent': instance.continent,
      'imageUrl': instance.imageUrl,
    };
