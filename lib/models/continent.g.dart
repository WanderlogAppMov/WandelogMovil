// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Continent _$ContinentFromJson(Map<String, dynamic> json) => Continent(
      continentID: (json['continentID'] as num).toInt(),
      continentName: json['continentName'] as String,
    );

Map<String, dynamic> _$ContinentToJson(Continent instance) => <String, dynamic>{
      'continentID': instance.continentID,
      'continentName': instance.continentName,
    };
