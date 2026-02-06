import 'package:flutter_prueba_ibk/databases/product_db.dart';
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
            'isLogout': isLogout as int,
          }
          in productMaps)
        ProductModel(
          typeAccount: typeAccount,
          codePAN: codePAN,
          name: name,
          nameMoney: nameMoney,
          symbolMoney: symbolMoney,
          amount: amount,
          isLogout: isLogout,
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
        'isLogout': value.isLogout,
      });
    }

    await batch.commit(noResult: true);
  }

  Future<void> deleteAllProducts() async {
    final db = await FinanceDatabase.database;
    await db.delete('products');
  }
}
