import 'dart:convert';
import '../models/TravelPackage.dart';
import '../network/api_client.dart';

class TravelPackageService {
  final ApiClient _apiClient = ApiClient();

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
    required int agencyId,
    required String continent,
  }) async {
    final packageData = {
      "destination": destination,
      "hotelId": hotelId,
      "restaurantId": restaurantId,
      "flightId": flightId,
      "attractionId": attractionId,
      "pricePerStudent": pricePerStudent,
      "agencyId": agencyId,
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
}
