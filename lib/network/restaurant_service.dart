import 'dart:convert';
import 'package:wanderlog_movil/models/restaurant.dart'; // Asegúrate de tener este modelo creado
import 'api_client.dart';

class RestaurantService {
  final ApiClient _apiClient = ApiClient();

  /// Obtiene todos los restaurantes desde el API
  Future<List<Restaurant>> getAllRestaurants() async {
    final response = await _apiClient.getRequest('api/restaurants');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((restaurant) => Restaurant.fromJson(restaurant)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to load restaurants');
    }
  }

  Future<List<Restaurant>> getAllRestaurantsByContinentId(int continentId) async {
    final response = await _apiClient.getRequest('api/restaurants/continent/$continentId');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((flight) => Restaurant.fromJson(flight)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load flights');
    }
  }

  /// Crea un nuevo restaurante en el API
  Future<void> createRestaurant({
    required String restaurantName,
    required String country,
    required String city,
    required String cuisineType,
    required String priceRange,
    required int continentId,
    required String imageUrl,
  }) async {
    final restaurantData = {
      "restaurantName": restaurantName,
      "country": country,
      "city": city,
      "cuisineType": cuisineType,
      "priceRange": priceRange,
      "continentId": continentId,
      "imageUrl": imageUrl,
    };

    final response = await _apiClient.postRequest(
      'api/restaurants', jsonEncode(restaurantData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Restaurant created successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to create restaurant');
    }
  }

  Future<void> updateRestaurant({
    required int restaurantId,
    required String restaurantName,
    required String country,
    required String city,
    required String cuisineType,
    required String priceRange,
    required int continentId,
    required String imageUrl,
  }) async {
    final restaurantData = {
      "restaurantName": restaurantName,
      "country": country,
      "city": city,
      "cuisineType": cuisineType,
      "priceRange": priceRange,
      "continentId": continentId,
      "imageUrl": imageUrl,
    };
    final response = await _apiClient.putRequest(
      'api/restaurants/$restaurantId', jsonEncode(restaurantData),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Restaurant updated successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to update restaurant');
    }
  }

  Future<void> deleteRestaurant(Restaurant restaurant)async {
    final response = await _apiClient.deleteRequest(
      'api/restaurants/${restaurant.restaurantId}'
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Restaurant deleted successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to deleted restaurant');
    }
  }
}