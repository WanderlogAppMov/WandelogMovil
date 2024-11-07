// attraction.dart
import 'package:json_annotation/json_annotation.dart';
import 'continent.dart';

part 'attraction.g.dart';

@JsonSerializable()
class Attraction {
  final int attractionId;
  final String attractionName;
  final String country;
  final String city;
  final double ticketPrice;
  final Continent continent;
  final String? imageUrl;

  Attraction({
    required this.attractionId,
    required this.attractionName,
    required this.country,
    required this.city,
    required this.ticketPrice,
    required this.continent,
    required this.imageUrl,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => _$AttractionFromJson(json);
  Map<String, dynamic> toJson() => _$AttractionToJson(this);
}
