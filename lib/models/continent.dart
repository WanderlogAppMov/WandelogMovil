// continent.dart
import 'package:json_annotation/json_annotation.dart';

part 'continent.g.dart';

@JsonSerializable()
class Continent {
  final int continentID;
  final String continentName;

  Continent({
    required this.continentID,
    required this.continentName,
  });

  factory Continent.fromParams(int continentID, String continentName) {
    return Continent(
      continentID: continentID,
      continentName: continentName,
    );
  }

  factory Continent.fromId(int continentID) {
    return Continent(
      continentID: continentID,
      continentName: "",
    );
  }

  factory Continent.fromJson(Map<String, dynamic> json) => _$ContinentFromJson(json);
  Map<String, dynamic> toJson() => _$ContinentToJson(this);
}
