// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      restaurantId: (json['restaurantId'] as num).toInt(),
      restaurantName: json['restaurantName'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      cuisineType: json['cuisineType'] as String,
      priceRange: json['priceRange'] as String,
      continent: Continent.fromJson(json['continent'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'restaurantName': instance.restaurantName,
      'country': instance.country,
      'city': instance.city,
      'cuisineType': instance.cuisineType,
      'priceRange': instance.priceRange,
      'continent': instance.continent,
      'imageUrl': instance.imageUrl,
    };
