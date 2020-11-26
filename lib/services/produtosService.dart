import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energapp/models/listaProdutoUsuario.dart';
import 'package:energapp/models/produtos.dart';
import 'package:energapp/models/produtosUsuario%20.dart';
import 'package:energapp/services/sharedPreferences.dart';

Future<List<Produtos>> getAllProdutos() async {
  try {
    Query query = FirebaseFirestore.instance.collection('produtos');
    List<Produtos> produtos = new List<Produtos>();
    var q = await query.get();
    for (var i = 0; i < q.docs.length; i++) {
      produtos.add(Produtos.fromJson(q.docs[i].data(), q.docs[i].id));
    }
    return produtos;
  } catch (e) {
    throw e;
  }
}

Future<bool> cadProd(String idProd, int tempo, int quantidade) async {
  try {
    var map = Map<String, dynamic>();
    map['idproduto'] = idProd;
    map['idusuario'] = await getId();
    map['quantidade'] = quantidade;
    map['tempo'] = tempo;
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('produtos_do_usuario')
        .add(map);
    return docRef.id != null;
  } catch (e) {
    throw e;
  }
}

Future<List<ListaProdutosUsuario>> listProdUser() async {
  try {
    var listProdutos = await getAllProdutos();
    var listProdutosUs = await getAllProdUser();
    var listaProdutoUsuario = List<ListaProdutosUsuario>();
    for (var i = 0; i < listProdutosUs.length; i++) {
      var item = listProdutosUs[i];
      var itemProd = listProdutos
          .firstWhere((element) => element.idProduto == item.idproduto);
      listaProdutoUsuario.add(ListaProdutosUsuario(
          idUsuario: item.idusuario,
          idProduto: item.idproduto,
          kWh: itemProd.kWh,
          modelo: itemProd.modelo,
          idDoc: item.idProdutosUsuario,
          quantidade: item.quantidade,
          tempo: item.tempo));
    }
    return listaProdutoUsuario;
  } catch (e) {
    throw e;
  }
}

Future<void> deleteProdUser(String idDoc) async {
  try {
    var del = await FirebaseFirestore.instance
        .collection('produtos_do_usuario')
        .doc(idDoc)
        .delete();
  } catch (e) {
    throw e;
  }
}

Future<List<ProdutosUsuario>> getAllProdUser() async {
  try {
    var idUser = await getId();
    Query query = FirebaseFirestore.instance.collection('produtos_do_usuario');
    List<ProdutosUsuario> produtos = new List<ProdutosUsuario>();
    var q = await query.where("idusuario", whereIn: [idUser]).get();
    for (var i = 0; i < q.docs.length; i++) {
      produtos.add(ProdutosUsuario.fromJson(q.docs[i].data(), q.docs[i].id));
    }
    return produtos;
  } catch (e) {
    throw e;
  }
}

double calc(List<ListaProdutosUsuario> prods) {
  // var dados = (prods.map((e) => e.kWh)).toList();
  double result = 0.0;
  for (var i = 0; i < prods.length; i++) {
    result += ((prods[i].kWh * prods[i].tempo) * prods[i].quantidade) * 30;
  }
  result = (result * 0.35118853) + (result * 0.39770492);
  return result;
}
