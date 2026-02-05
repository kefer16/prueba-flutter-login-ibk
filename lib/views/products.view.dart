import 'package:flutter/material.dart';
import 'package:flutter_prueba_ibk/components/custom_card_product.component.dart';
import 'package:flutter_prueba_ibk/models/product.model.dart';
import 'package:flutter_prueba_ibk/services/products.service.dart';
import 'package:flutter_prueba_ibk/views/login.view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late Future<List<ProductModel>> futureProducts;

  Future<List<ProductModel>> _getProducts() async {
    return ProductsRepository().getProducts(); // simula API
  }

  Future<void> _removeSesion() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('is_sesion_active');
    });
  }

  @override
  void initState() {
    super.initState();
    futureProducts = _getProducts();
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            FutureBuilder<List<ProductModel>>(
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

                return Column(
                  children: snapshot.data!
                      .map(
                        (item) => Column(
                          children: [
                            CustomCardProduct(product: item),
                            SizedBox(height: 15),
                          ],
                        ),
                      )
                      .toList(),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD5D4D4),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  _removeSesion();
                  Get.offAll(() => const LoginView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFFEF2F2),
                          ),
                          // width: 70,
                          padding: EdgeInsets.all(14),
                          child: Icon(
                            Icons.logout_rounded,
                            size: 20,
                            color: Color(0xFFDF3C3C),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cerrar Sesión',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFDF3C3C),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
