import 'package:flutter/material.dart';

class CustomCardMoviminetos extends StatelessWidget {
  final String symbolMoney;
  final bool esCasa;
  final bool esIngreso;
  final String nombre;
  final String fecha;
  final String hora;
  final String monto;

  const CustomCardMoviminetos({
    super.key,
    this.symbolMoney = "",
    this.esCasa = false,
    this.esIngreso = false,
    this.nombre = "",
    this.fecha = "",
    this.hora = "",
    this.monto = "",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xFFE7EEF4),
              ),
              // width: 70,
              padding: EdgeInsets.all(10),
              child: Icon(
                esCasa ? Icons.house_rounded : Icons.shopping_bag_rounded,
                size: 20,
                color: Color(0xFF475569),
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '$fecha - $hora',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF65748B),
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          '${esIngreso ? '+' : '-'} $symbolMoney $monto',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: esIngreso ? Color(0xFF069669) : Color(0xFFDF3C3C),
          ),
        ),
      ],
    );
  }
}
