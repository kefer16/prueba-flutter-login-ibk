import 'package:flutter/material.dart';
import 'package:flutter_prueba_ibk/components/custom_card_product.component.dart';
import 'package:flutter_prueba_ibk/components/custom_cerrar_sesion.component.dart';
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

  Future<List<ProductModel>> _getProducts(bool isRefresh) async {
    return ProductsRepository().getProducts(isRefresh); // simula API
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      futureProducts = _getProducts(true);
    });
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
    futureProducts = _getProducts(false);
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

                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return (snapshot.data![index].isLogout == 1)
                            ? CustomCerrarSesion(
                                onPressed: () {
                                  _removeSesion();
                                  Get.offAll(() => const LoginView());
                                },
                              )
                            : Column(
                                children: [
                                  CustomCardProduct(
                                    product: snapshot.data![index],
                                  ),
                                  SizedBox(height: 15),
                                ],
                              );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
