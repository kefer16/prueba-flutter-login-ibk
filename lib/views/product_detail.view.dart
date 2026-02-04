import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prueba_ibk/components/custom_card_movimientos.component.dart';
import 'package:flutter_prueba_ibk/models/movement.model.dart';
import 'package:flutter_prueba_ibk/models/product.model.dart';
import 'package:flutter_prueba_ibk/services/movements.service.dart';
import 'package:get/get.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late Future<List<MovementModel>> futureMovements;

  Future<List<MovementModel>> getMovements() async {
    return MovementsRepository().getMovements(); // simula API
  }

  @override
  void initState() {
    super.initState();
    futureMovements = getMovements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Productos detalle',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
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
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: widget.product.typeAccount == 1
                              ? const Color(0xFFEFF6FF)
                              : (widget.product.typeAccount == 2
                                    ? Color(0xFFEFF0F8)
                                    : Color(0xFFECFDF5)),
                        ),
                        // width: 70,
                        padding: EdgeInsets.all(14),
                        child: Icon(
                          widget.product.typeAccount == 1
                              ? Icons.payment_rounded
                              : (widget.product.typeAccount == 2
                                    ? Icons.work_rounded
                                    : Icons.savings_rounded),
                          size: 22,
                          color: widget.product.typeAccount == 1
                              ? Color(0xFF3B82F6)
                              : (widget.product.typeAccount == 2
                                    ? Color(0xFF7174F2)
                                    : Color(0xFF069669)),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.product.name} - ${widget.product.nameMoney}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${widget.product.symbolMoney} ${widget.product.amount}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NÚMERO DE CUENTA',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF9EABBF),
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            widget.product.codePAN,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: widget.product.codePAN),
                          );

                          Get.snackbar('Éxito', 'Texto copiado');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: const Color(0xFFE8EAFB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.copy_rounded,
                              size: 14,
                              color: Color(0xFF7174F2),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Copiar',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF7174F2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Movimientos',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<MovementModel>>(
              future: futureMovements,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No hay cuentas');
                }

                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CustomCardMoviminetos(
                            esCasa: snapshot.data![index].esCasa,
                            esIngreso: snapshot.data![index].esIngreso,
                            fecha: snapshot.data![index].fecha,
                            monto: snapshot.data![index].monto,
                            nombre: snapshot.data![index].nombre,
                            hora: snapshot.data![index].hora,
                            symbolMoney: widget.product.symbolMoney,
                          ),
                          SizedBox(height: 15),
                        ],
                      );
                    },
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
