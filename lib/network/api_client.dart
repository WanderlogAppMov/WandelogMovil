import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://874e-179-6-12-21.ngrok-free.app/';

  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.get(url);
  }

  Future<http.Response> postRequest(String endpoint, String body) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body
    );
  }

  Future<http.Response> putRequest(String endpoint, String body) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body
    );
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.delete(url);
  }
}