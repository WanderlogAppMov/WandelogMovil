import 'dart:convert';
import 'package:wanderlog_movil/models/attraction.dart';
import 'api_client.dart';

class AttractionService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Attraction>> getAllAttraction() async {
    final response = await _apiClient.getRequest('api/attractions');
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((attraction) => Attraction.fromJson(attraction)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to load attractions');
    }
  }

  Future<List<Attraction>> getAllAttractionsByContinentId(int continentId) async {
    final response = await _apiClient.getRequest('api/attractions/continent/$continentId');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((flight) => Attraction.fromJson(flight)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load flights');
    }
  }

  Future<void> createAttraction({
    required String attractionName,
    required String country,
    required String city,
    required double ticketPrice,
    required int continentId,
    required String imageUrl,
  }) async {
    final attractionData = {
      "attractionName": attractionName,
      "country": country,
      "city": city,
      "ticketPrice": ticketPrice,
      "continentId": continentId,
      "imageUrl": imageUrl,
    };

    final response = await _apiClient.postRequest(
      'api/attractions', jsonEncode(attractionData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Attraction created successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to create attraction');
    }
  }

  Future<void> updateAttraction({
    required int attractionId,
    required String attractionName,
    required String country,
    required String city,
    required double ticketPrice,
    required int continentId,
    required String imageUrl,
  }) async {
    final attractionData = {
      "attractionName": attractionName,
      "country": country,
      "city": city,
      "ticketPrice": ticketPrice,
      "continentId": continentId,
      "imageUrl": imageUrl,
    };

    final response = await _apiClient.putRequest(
      'api/attractions/$attractionId', jsonEncode(attractionData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Attraction $attractionId updated successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to updated attraction');
    }
  }

  Future<void> deleteAttraction(Attraction attraction)async {
    final response = await _apiClient.deleteRequest(
      'api/attractions/${attraction.attractionId}'
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Attraction created successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to create attraction');
    }
  }
}