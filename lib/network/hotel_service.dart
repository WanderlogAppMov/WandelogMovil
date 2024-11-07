import 'dart:convert';
import '../models/hotels.dart';
import '../network/api_client.dart';

class HotelService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Hotel>> getAllHotels() async {
    final response = await _apiClient.getRequest('api/hotels');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((hotel) => Hotel.fromJson(hotel)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }
  }

  Future<List<Hotel>> getAllHotelsByContinentId(int continentId) async {
    final response = await _apiClient.getRequest('api/hotels/continent/$continentId');
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((flight) => Hotel.fromJson(flight)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load flights');
    }
  }

  Future<void> createHotel({
    required String hotelName,
    required String country,
    required String city,

    required int stars,
    required double pricePerNight,
    required int continentId,

    required String imageUrl,
  }) async {
    final hotelData = {
      "hotelName": hotelName,
      "country": country,
      "city": city,
      "stars": stars,
      "pricePerNight": pricePerNight,
      "continentId": continentId,
      "imageUrl": imageUrl,
    };

    final response = await _apiClient.postRequest(
      'api/hotels', jsonEncode(hotelData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Hotel created successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to create hotel');
    }
  }

  Future<void> updateHotel({
    required int hotelId,
    required String hotelName,
    required String country,
    required String city,

    required int stars,
    required double pricePerNight,
    required int continentId,

    required String imageUrl,
  }) async {
    final hotelData = {
      "hotelName": hotelName,
      "country": country,
      "city": city,
      "stars": stars,
      "pricePerNight": pricePerNight,
      "continentId": continentId,
      "imageUrl": imageUrl,
    };

    final response = await _apiClient.putRequest(
      'api/hotels/$hotelId', jsonEncode(hotelData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Hotel updated successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to update hotel');
    }
  }

  Future<void> deleteHotel(Hotel hotel) async {
    final response = await _apiClient.deleteRequest(
      'api/hotels/${hotel.hotelId}'
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Hotel deleted successfully');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to delete hotel');
    }
  }
}