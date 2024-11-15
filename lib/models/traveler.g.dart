// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traveler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Traveler _$TravelerFromJson(Map<String, dynamic> json) => Traveler(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TravelerToJson(Traveler instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'username': instance.username,
      'password': instance.password,
      'roles': instance.roles,
    };
