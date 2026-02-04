import 'package:flutter/material.dart';
import 'package:flutter_prueba_ibk/models/product.model.dart';
import 'package:flutter_prueba_ibk/views/product_detail.view.dart';
import 'package:get/get.dart';

class CustomCardProduct extends StatelessWidget {
  final ProductModel product;

  const CustomCardProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Get.to(() => ProductDetailView(product: product));
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
                    color: product.typeAccount == 1
                        ? const Color(0xFFEFF6FF)
                        : (product.typeAccount == 2
                              ? Color(0xFFEFF0F8)
                              : Color(0xFFECFDF5)),
                  ),
                  // width: 70,
                  padding: EdgeInsets.all(14),
                  child: Icon(
                    product.typeAccount == 1
                        ? Icons.payment_rounded
                        : (product.typeAccount == 2
                              ? Icons.work_rounded
                              : Icons.savings_rounded),
                    size: 20,
                    color: product.typeAccount == 1
                        ? Color(0xFF3B82F6)
                        : (product.typeAccount == 2
                              ? Color(0xFF7174F2)
                              : Color(0xFF069669)),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.name} - ${product.nameMoney}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF65748B),
                      ),
                    ),
                    Text(
                      '${product.symbolMoney} ${product.amount}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              // width: 70,
              child: Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9EABBF),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
