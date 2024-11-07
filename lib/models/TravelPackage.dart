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
  final Hotel? hotel; // Hazlo opcional
  final Restaurant? restaurant;
  final Flight? flight;
  final Attraction? attraction;
  final double pricePerStudent;
  final Agency agency;
  final String continent;

  TravelPackage({
    required this.travelPackageId,
    required this.destination,
    required this.hotel,
    required this.restaurant,
    required this.flight,
    required this.attraction,
    required this.pricePerStudent,
    required this.agency,
    required this.continent,
  });

  factory TravelPackage.fromJson(Map<String, dynamic> json) => _$TravelPackageFromJson(json);
  Map<String, dynamic> toJson() => _$TravelPackageToJson(this);
}
