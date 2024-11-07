// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attraction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attraction _$AttractionFromJson(Map<String, dynamic> json) => Attraction(
      attractionId: (json['attractionId'] as num).toInt(),
      attractionName: json['attractionName'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      ticketPrice: (json['ticketPrice'] as num).toDouble(),
      continent: Continent.fromJson(json['continent'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$AttractionToJson(Attraction instance) =>
    <String, dynamic>{
      'attractionId': instance.attractionId,
      'attractionName': instance.attractionName,
      'country': instance.country,
      'city': instance.city,
      'ticketPrice': instance.ticketPrice,
      'continent': instance.continent,
      'imageUrl': instance.imageUrl,
    };
