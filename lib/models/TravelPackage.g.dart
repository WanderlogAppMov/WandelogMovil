// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TravelPackage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelPackage _$TravelPackageFromJson(Map<String, dynamic> json) =>
    TravelPackage(
      travelPackageId: (json['travelPackageId'] as num).toInt(),
      destination: json['destination'] as String,
      hotel: json['hotel'] == null
          ? null
          : Hotel.fromJson(json['hotel'] as Map<String, dynamic>),
      restaurant: json['restaurant'] == null
          ? null
          : Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      flight: json['flight'] == null
          ? null
          : Flight.fromJson(json['flight'] as Map<String, dynamic>),
      attraction: json['attraction'] == null
          ? null
          : Attraction.fromJson(json['attraction'] as Map<String, dynamic>),
      pricePerStudent: (json['pricePerStudent'] as num).toDouble(),
      agency: Agency.fromJson(json['agency'] as Map<String, dynamic>),
      continent: json['continent'] as String,
    );

Map<String, dynamic> _$TravelPackageToJson(TravelPackage instance) =>
    <String, dynamic>{
      'travelPackageId': instance.travelPackageId,
      'destination': instance.destination,
      'hotel': instance.hotel,
      'restaurant': instance.restaurant,
      'flight': instance.flight,
      'attraction': instance.attraction,
      'pricePerStudent': instance.pricePerStudent,
      'agency': instance.agency,
      'continent': instance.continent,
    };
