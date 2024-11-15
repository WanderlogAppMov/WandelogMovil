import 'package:json_annotation/json_annotation.dart';

part 'traveler.g.dart';

@JsonSerializable()
class Traveler {
  final String firstName;
  final String lastName;
  final String gender;
  final String birthdate;
  final String username;
  final String password;
  final List<String> roles;

  Traveler({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthdate,
    required this.username,
    required this.password,
    required this.roles,
  });

  factory Traveler.fromJson(Map<String, dynamic> json) => _$TravelerFromJson(json);
  Map<String, dynamic> toJson() => _$TravelerToJson(this);
}