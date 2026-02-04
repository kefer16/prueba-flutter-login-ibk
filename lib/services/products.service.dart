import 'dart:convert';
import 'package:flutter_prueba_ibk/models/product.model.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  final String _baseUrl = 'http://demo8356743.mockable.io/ibk_get_products';

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List productsJson = data['products'];

        return productsJson.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('get products failed: $e');
      return [];
    }
  }
}
