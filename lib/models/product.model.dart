class ProductModel {
  int typeAccount;
  String codePAN;
  String name;
  String nameMoney;
  String symbolMoney;
  String amount;

  ProductModel({
    this.typeAccount = 0,
    this.codePAN = "",
    this.name = "",
    this.nameMoney = "",
    this.symbolMoney = "",
    this.amount = "",
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      typeAccount: json['typeAccount'],
      codePAN: json['codePAN'],
      name: json['name'],
      nameMoney: json['nameMoney'],
      symbolMoney: json['symbolMoney'],
      amount: json['amount'],
    );
  }
}
