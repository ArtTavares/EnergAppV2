class ListaProdutosUsuario {
  String idDoc;
  String idUsuario;
  String idProduto;
  String modelo;
  double kWh;
  int quantidade;
  int tempo;

  ListaProdutosUsuario(
      {this.idUsuario,
      this.idProduto,
      this.kWh,
      this.modelo,
      this.idDoc,
      this.quantidade,
      this.tempo});
}
