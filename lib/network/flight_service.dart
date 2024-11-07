import 'dart:convert';
import 'package:wanderlog_movil/models/flight.dart'; // Asegúrate de tener este modelo
import 'api_client.dart';

class FlightService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Flight>> getAllFlights() async {
    final response = await _apiClient.getRequest('api/flights');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((flight) => Flight.fromJson(flight)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load flights');
    }
  }


  Future<List<Flight>> getAllFlightsByContinentId(int continentId) async {
    final response = await _apiClient.getRequest('api/flights/continent/$continentId');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((flight) => Flight.fromJson(flight)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load flights');
    }
  }

  Future<void> createFlight({
    required String airline,
    required String departureCountry,
    required String arrivalCountry,
    required double price,
    required int continentId,
    required String imageUrl,
  }) async {
    final flightData = {
      "airline": airline,
      "departureCountry": departureCountry,
      "arrivalCountry": arrivalCountry,
      "price": price,
      "continentId": continentId,
      "continentName": "",
      "imageUrl": imageUrl,
    };

    final response = await _apiClient.postRequest(
      'api/flights',
      jsonEncode(flightData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Flight created successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to create flight');
    }
  }

  Future<void> updateFlight({
    required int flightId,
    required String airline,
    required String departureCountry,
    required String arrivalCountry,
    required double price,
    required int continentId,
    required String imageUrl,
  }) async {
    final flightData = {
      "airline": airline,
      "departureCountry": departureCountry,
      "arrivalCountry": arrivalCountry,
      "price": price,
      "continentId": continentId,
      "continentName": "",
      "imageUrl": imageUrl,
    };

    final response = await _apiClient.putRequest(
      'api/flights/$flightId',
      jsonEncode(flightData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Flight created successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to create flight');
    }
  }
  
  Future<bool> deleteFlight(Flight flight) async {
    try {
      final response = await _apiClient.deleteRequest('api/flights/${flight.flightId}');
      return response.statusCode == 200;
    } catch (e){
      print("Error on deleting: $e");
      return false;
    }
  }
}