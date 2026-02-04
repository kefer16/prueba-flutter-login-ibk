import 'dart:convert';
import 'package:flutter_prueba_ibk/models/movement.model.dart';
import 'package:http/http.dart' as http;

class MovementsRepository {
  final String _baseUrl = 'http://demo8356743.mockable.io/ibk_get_movements';

  Future<List<MovementModel>> getMovements() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List movementsJson = data['movements'];

        return movementsJson
            .map((json) => MovementModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('get movements failed: $e');
      return [];
    }
  }
}
