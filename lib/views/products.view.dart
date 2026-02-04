import 'package:flutter/material.dart';
import 'package:flutter_prueba_ibk/components/custom_card_product.component.dart';
import 'package:flutter_prueba_ibk/models/product.model.dart';
import 'package:flutter_prueba_ibk/services/products.service.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late Future<List<ProductModel>> futureProducts;

  Future<List<ProductModel>> getProducts() async {
    return ProductsRepository().getProducts(); // simula API
  }

  @override
  void initState() {
    super.initState();
    futureProducts = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis cuentas',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 80,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No hay cuentas');
          }

          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CustomCardProduct(product: snapshot.data![index]),
                    SizedBox(height: 15),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
