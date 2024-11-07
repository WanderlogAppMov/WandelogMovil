// restaurant.dart
import 'package:json_annotation/json_annotation.dart';
import 'continent.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final int restaurantId;
  final String restaurantName;
  final String country;
  final String city;
  final String cuisineType;
  final String priceRange;
  final Continent continent;
  final String imageUrl;

  Restaurant({
    required this.restaurantId,
    required this.restaurantName,
    required this.country,
    required this.city,
    required this.cuisineType,
    required this.priceRange,
    required this.continent,
    required this.imageUrl
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
