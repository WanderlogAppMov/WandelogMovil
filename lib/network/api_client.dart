import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://6fb0-2800-200-e200-2d3-947d-7f1b-2d3e-ad73.ngrok-free.app/';
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      },
    );
  }

  Future<http.Response> postRequest(String endpoint, String body, {bool includeAuth = true}) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {
      'Content-Type': 'application/json',
      if (includeAuth && _token != null) 'Authorization': 'Bearer $_token',
    };
    return await http.post(
      url,
      headers: headers,
      body: body,
    );
  }

  Future<http.Response> putRequest(String endpoint, String body) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      },
      body: body,
    );
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      },
    );
  }
}