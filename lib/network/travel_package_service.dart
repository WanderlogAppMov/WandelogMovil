import 'dart:convert';
import '../models/TravelPackage.dart';
import '../network/api_client.dart';

class TravelPackageService {
  final ApiClient _apiClient;

  TravelPackageService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<TravelPackage>> getAllTravelPackages() async {
    final response = await _apiClient.getRequest('api/travelpackages');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((package) => TravelPackage.fromJson(package)).toList();
    } else {
      throw Exception('Failed to load travel packages');
    }
  }

  Future<void> createTravelPackage({
    required String destination,
    required int hotelId,
    required int restaurantId,
    required int flightId,
    required int attractionId,
    required double pricePerStudent,
    required String continent,
  }) async {
    final packageData = {
      "destination": destination,
      "hotelId": hotelId,
      "restaurantId": restaurantId,
      "flightId": flightId,
      "attractionId": attractionId,
      "pricePerStudent": pricePerStudent,
      "continent": continent,
    };
    final response = await _apiClient.postRequest(
      'api/travelpackages',
      jsonEncode(packageData),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Travel package created successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to create travel package');
    }
  }



  Future<void> updateTravelPackageFull({
    required int travelPackageId,
    required String body, // Ahora recibe un JSON String directamente
  }) async {
    final response = await _apiClient.putRequest(
      'api/travelpackages/$travelPackageId', // URL con el ID
      body, // Pasa el JSON String directamente
    );

    if (response.statusCode == 200) {
      print('Travel package updated successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to update travel package');
    }
  }
  Future<void> deleteTravelPackage(int id) async {
    final response = await _apiClient.deleteRequest('api/travelpackages/$id');
    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Travel package deleted successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to delete travel package');
    }
  }

  Future<void> updateTravelPackage({
    required int id,
    required String destination,
    required int hotelId,
    required int restaurantId,
    required int flightId,
    required int attractionId,
    required double pricePerStudent,
    required String continent,
  }) async {
    final packageData = {
      "destination": destination,
      "hotelId": hotelId,
      "restaurantId": restaurantId,
      "flightId": flightId,
      "attractionId": attractionId,
      "pricePerStudent": pricePerStudent,
      "continent": continent,
    };
    final response = await _apiClient.putRequest(
      'api/travelpackages/$id',
      jsonEncode(packageData),
    );
    if (response.statusCode == 200) {
      print('Travel package updated successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to update travel package');
    }
  }


}
