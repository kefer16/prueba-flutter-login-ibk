class MovementModel {
  bool esCasa = false;
  bool esIngreso = false;
  String nombre = "";
  String fecha = "";
  String hora = "";
  String nameMoney = "";
  String symbolMoney = "";
  String monto = "";

  MovementModel({
    required this.esCasa,
    required this.esIngreso,
    required this.nombre,
    required this.fecha,
    required this.hora,
    required this.nameMoney,
    required this.symbolMoney,
    required this.monto,
  });

  factory MovementModel.fromJson(Map<String, dynamic> json) {
    return MovementModel(
      esCasa: json['esCasa'],
      esIngreso: json['esIngreso'],
      nombre: json['nombre'],
      fecha: json['fecha'],
      hora: json['hora'],
      nameMoney: json['nameMoney'],
      symbolMoney: json['symbolMoney'],
      monto: json['monto'],
    );
  }
}
