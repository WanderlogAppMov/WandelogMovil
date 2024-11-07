import 'package:json_annotation/json_annotation.dart';
import 'continent.dart'; // Importa el modelo de Continent

part 'hotels.g.dart';

@JsonSerializable()
class Hotel {
  final int hotelId;
  final String hotelName;
  final String country;
  final String city;
  final String imageUrl;
  final int stars;
  final double pricePerNight;
  final Continent continent; // Usa el modelo de Continent importado

  Hotel({
    required this.hotelId,
    required this.hotelName,
    required this.country,
    required this.city,
    required this.imageUrl,
    required this.stars,
    required this.pricePerNight,
    required this.continent,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);
  Map<String, dynamic> toJson() => _$HotelToJson(this);
}
