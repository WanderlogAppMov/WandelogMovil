// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
      agencyId: (json['agencyId'] as num).toInt(),
      organizationName: json['organizationName'] as String,
      repreFirstName: json['repreFirstName'] as String,
      repreLastName: json['repreLastName'] as String,
      contactEmail: json['contactEmail'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
      'agencyId': instance.agencyId,
      'organizationName': instance.organizationName,
      'repreFirstName': instance.repreFirstName,
      'repreLastName': instance.repreLastName,
      'contactEmail': instance.contactEmail,
      'password': instance.password,
    };
