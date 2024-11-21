import 'package:json_annotation/json_annotation.dart';
import 'hotels.dart';  // Importa la definición de Hotel y Continent aquí
import 'restaurant.dart';  // Importa la definición de Restaurant aquí
import 'flight.dart';  // Importa la definición de Flight aquí
import 'attraction.dart';  // Importa la definición de Attraction aquí
import 'agency.dart';  // Importa la definición de Agency aquí

part 'TravelPackage.g.dart';

@JsonSerializable()
class TravelPackage {
  final int travelPackageId;
  final String destination;
  final Hotel? hotel;
  final Restaurant? restaurant;
  final Flight? flight;
  final Attraction? attraction;
  final double pricePerStudent;
  final String continent;
  final int reserved;

  TravelPackage({
    required this.travelPackageId,
    required this.destination,
    required this.hotel,
    required this.restaurant,
    required this.flight,
    required this.attraction,
    required this.pricePerStudent,
    required this.continent,
    required this.reserved,
  });

  factory TravelPackage.fromJson(Map<String, dynamic> json) => _$TravelPackageFromJson(json);
  Map<String, dynamic> toJson() => _$TravelPackageToJson(this);
}
