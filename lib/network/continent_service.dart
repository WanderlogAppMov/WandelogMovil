// continent_service.dart
import 'dart:convert';
import 'package:wanderlog_movil/models/continent.dart';
import 'api_client.dart';

class ContinentService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Continent>> getAllContinents() async {
    final response = await _apiClient.getRequest('api/continents');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((continent) => Continent.fromJson(continent)).toList();
    } else {
      throw Exception('Failed to load continents');
    }
  }

  Future<void> createContinent({
    required String continentName,
  }) async {
    final continentData = {
      "continentName": continentName,
    };

    final response = await _apiClient.postRequest(
      'api/continents', jsonEncode(continentData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Continent created successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to create continent');
    }
  }

  Future<void> editContinent({
    required Continent continent,
  }) async {
    final continentData = {
      "continentName": continent.continentName,
    };

    final response = await _apiClient.putRequest(
      'api/continents/${continent.continentID}', jsonEncode(continentData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Continent updated successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to update continent');
    }
  }

  Future<void> deleteContinent({
    required Continent continent
  }) async {
    final response = await _apiClient.deleteRequest(
      'api/continents/${continent.continentID}',
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Continent deleted successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to delete continent');
    }
  }
}