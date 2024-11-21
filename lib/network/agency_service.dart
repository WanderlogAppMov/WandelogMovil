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
  Future<Map<String, dynamic>> getProfileById(String id) async {
    final response = await _apiClient.getRequest('api/travelagencies/$id/profile');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updateProfileById(String agencyId, Map<String, String> profileData) async {
    final response = await _apiClient.putRequest(
      'api/agencies/$agencyId',
      jsonEncode(profileData),
    );

    if (response.statusCode == 200) {
      print('Profile updated successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update profile');
    }
  }
}