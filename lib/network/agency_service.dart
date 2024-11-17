import 'dart:convert';
import 'api_client.dart';

class AgencyService {
  final ApiClient _apiClient;

  AgencyService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<void> registerAgency({
    required String organizationName,
    required String repreFirstName,
    required String repreLastName,
    required String username,
    required String password,
    required List<String> roles,
  }) async {
    final agencyData = {
      "organizationName": organizationName,
      "repreFirstName": repreFirstName,
      "repreLastName": repreLastName,
      "username": username,
      "password": password,
      "roles": roles,
    };

    final response = await _apiClient.postRequest(
      'api/travelagencies',
      jsonEncode(agencyData),
      includeAuth: false,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Agency registered successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      print('Response body: ${response.body}');
      print('Response headers: ${response.headers}');
      throw Exception('Failed to register agency');
    }
  }
}