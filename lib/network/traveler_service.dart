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
  Future<Map<String, dynamic>> getProfileById(String id) async {
    final response = await _apiClient.getRequest('api/travelers/$id/profile');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load profile');
    }
  }
  Future<void> updateProfileById(String userId, Map<String, String> profileData) async {
    // Ensure the userId is included in the profileData
    profileData['userId'] = userId;

    final response = await _apiClient.putRequest(
      'api/travelers/$userId',
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