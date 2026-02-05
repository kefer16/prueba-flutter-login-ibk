import 'package:flutter_prueba_ibk/databases/bd_product.dart';
import 'package:flutter_prueba_ibk/models/product.model.dart';

class ProductDao {
  Future<List<ProductModel>> getProductsCache() async {
    final db = await FinanceDatabase.database;
    final List<Map<String, Object?>> productMaps = await db.query('products');

    return [
      for (final {
            'typeAccount': typeAccount as int,
            'codePAN': codePAN as String,
            'name': name as String,
            'nameMoney': nameMoney as String,
            'symbolMoney': symbolMoney as String,
            'amount': amount as String,
          }
          in productMaps)
        ProductModel(
          typeAccount: typeAccount,
          codePAN: codePAN,
          name: name,
          nameMoney: nameMoney,
          symbolMoney: symbolMoney,
          amount: amount,
        ),
    ];
  }

  Future<void> insertAllCache(List<ProductModel> values) async {
    final db = await FinanceDatabase.database;
    final batch = db.batch();

    for (final value in values) {
      batch.insert('products', {
        'typeAccount': value.typeAccount,
        'codePAN': value.codePAN,
        'name': value.name,
        'nameMoney': value.nameMoney,
        'symbolMoney': value.symbolMoney,
        'amount': value.amount,
      });
    }

    await batch.commit(noResult: true);
  }
}
