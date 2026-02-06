import 'dart:convert';
import 'package:flutter_prueba_ibk/databases/product_dao.dart';
import 'package:flutter_prueba_ibk/models/product.model.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  final String _baseUrl = 'http://demo8356743.mockable.io/ibk_get_products';
  final ProductDao _dao = ProductDao();

  Future<List<ProductModel>> getProducts(bool isRefresh) async {
    try {
      final localData = await _dao.getProductsCache();

      if (localData.isNotEmpty && !isRefresh) {
        return localData;
      }

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List productsJson = data['products'];

        final result = productsJson
            .map((json) => ProductModel.fromJson(json))
            .toList();

        await _dao.deleteAllProducts();
        await _dao.insertAllCache(result);
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print('get products failed: $e');
      return [];
    }
  }
}
