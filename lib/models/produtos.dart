class Produtos {
  String idProduto;
  String marca;
  double kWh;
  String modelo;

  Produtos({this.marca, this.kWh, this.modelo, this.idProduto});

  Produtos.fromJson(Map<String, dynamic> json, String id) {
    idProduto = id;
    marca = json['Marca'];
    kWh = double.parse(json['kWh'].toString());
    modelo = json['Modelo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marca'] = this.marca;
    data['kWh'] = this.kWh;
    data['modelo'] = this.modelo;
    return data;
  }
}
