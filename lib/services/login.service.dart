import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginRepository {
  final String _baseUrl = 'http://demo8356743.mockable.io/ibk_login';

  Future<bool> postLogin(String dni, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': dni, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Assuming the API returns a JSON object with a 'success' field
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data.values.first;
      } else {
        return false;
      }
    } catch (e) {
      print('get products failed: $e');
      return false;
    }
  }
}
