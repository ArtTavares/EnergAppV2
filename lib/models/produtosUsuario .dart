class ProdutosUsuario {
  String idProdutosUsuario;
  int tempo;
  String idproduto;
  int quantidade;
  String idusuario;
  int dias;

  ProdutosUsuario(
      {this.idProdutosUsuario,
      this.tempo,
      this.idproduto,
      this.quantidade,
      this.idusuario,
      this.dias});

  ProdutosUsuario.fromJson(Map<String, dynamic> json, String id) {
    idProdutosUsuario = id;
    tempo = json['tempo'];
    idproduto = json['idproduto'];
    quantidade = json['quantidade'];
    idusuario = json['idusuario'];
    idusuario = json['idusuario'];
    dias = json['dias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tempo'] = this.tempo;
    data['idproduto'] = this.idproduto;
    data['quantidade'] = this.quantidade;
    data['idusuario'] = this.idusuario;
    data['dias'] = this.dias;
    return data;
  }
}
