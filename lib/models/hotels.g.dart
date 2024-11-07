// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      hotelId: (json['hotelId'] as num).toInt(),
      hotelName: json['hotelName'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      imageUrl: json['imageUrl'] as String,
      stars: (json['stars'] as num).toInt(),
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      continent: Continent.fromJson(json['continent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'hotelId': instance.hotelId,
      'hotelName': instance.hotelName,
      'country': instance.country,
      'city': instance.city,
      'imageUrl': instance.imageUrl,
      'stars': instance.stars,
      'pricePerNight': instance.pricePerNight,
      'continent': instance.continent,
    };
