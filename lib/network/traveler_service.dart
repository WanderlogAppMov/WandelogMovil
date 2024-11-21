import 'dart:convert';
import 'api_client.dart';

class TravelerService {
  final ApiClient _apiClient;

  TravelerService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<void> registerTraveler({
    required String firstName,
    required String lastName,
    required String gender,
    required String birthdate,
    required String username,
    required String password,
    required List<String> roles,
  }) async {
    final travelerData = {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "birthdate": birthdate,
      "username": username,
      "password": password,
      "roles": roles,
    };

    final response = await _apiClient.postRequest(
      'api/travelers',
      jsonEncode(travelerData),
      includeAuth: false,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Traveler registered successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      print('Response body: ${response.body}');
      print('Response headers: ${response.headers}');
      throw Exception('Failed to register traveler');
    }
  }
}