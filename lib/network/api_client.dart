import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://wanderlogbackend-ggd6esgxhuddhvb2.canadacentral-01.azurewebsites.net/';
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
    print('GET Headers: $headers');
    return await http.get(url, headers: headers);
  }

  Future<http.Response> postRequest(String endpoint, String body, {bool includeAuth = true}) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {
      'Content-Type': 'application/json',
      if (includeAuth && _token != null) 'Authorization': 'Bearer $_token', // Incluye el prefijo 'Bearer'
    };
    print('POST Headers: $headers');
    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> putRequest(String endpoint, String body) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token', // Incluye el prefijo 'Bearer'
    };
    print('PUT Headers: $headers');
    return await http.put(url, headers: headers, body: body);
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    final headers = {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token', // Incluye el prefijo 'Bearer'
    };
    print('DELETE Headers: $headers');
    return await http.delete(url, headers: headers);
  }
}
