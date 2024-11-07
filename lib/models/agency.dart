// agency.dart
import 'package:json_annotation/json_annotation.dart';

part 'agency.g.dart';

@JsonSerializable()
class Agency {
  final int agencyId;
  final String organizationName;
  final String repreFirstName;
  final String repreLastName;
  final String contactEmail;
  final String password;

  Agency({
    required this.agencyId,
    required this.organizationName,
    required this.repreFirstName,
    required this.repreLastName,
    required this.contactEmail,
    required this.password,
  });

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}
