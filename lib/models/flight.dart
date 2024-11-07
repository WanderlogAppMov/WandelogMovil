// flight.dart
import 'package:json_annotation/json_annotation.dart';
import 'continent.dart';

part 'flight.g.dart';

@JsonSerializable()
class Flight {
  final int flightId;
  final String airline;
  final String departureCountry;
  final String arrivalCountry;
  final double price;
  final Continent continent;
  final String? imageUrl; // Cambia a opcional si puede ser nulo

  Flight({
    required this.flightId,
    required this.airline,
    required this.departureCountry,
    required this.arrivalCountry,
    required this.price,
    required this.continent,
    required this.imageUrl
  });

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);
  Map<String, dynamic> toJson() => _$FlightToJson(this);
}
