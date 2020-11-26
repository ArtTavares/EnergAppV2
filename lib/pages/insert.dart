import 'package:dropdown_search/dropdown_search.dart';
import 'package:energapp/models/produtos.dart';
import 'package:energapp/services/produtosService.dart';
import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/color.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/scaffold.dart';
import 'package:flutter/material.dart';

class InserirPage extends StatefulWidget {
  @override
  _InserirPageState createState() => _InserirPageState();
}

class _InserirPageState extends State<InserirPage> {
  var _tempo = TextEditingController();
  var _quantidade = TextEditingController();
  String _idProduto;
  var listaProdutos = new List<Produtos>();
  @override
  Widget build(BuildContext context) {
    return scaffold(context, "Inserir", body(context));
  }

  Widget body(BuildContext context) {
    return FutureBuilder<List<Produtos>>(
      future: getAllProdutos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            listaProdutos = snapshot.data;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _container(context, _listarSelectProdutos(snapshot.data)),
                  input(context, _tempo, "Tempo Médio Ligado", "errorText"),
                  input(context, _quantidade, "Quantidade", "errorText",
                      keyboardType: TextInputType.number),
                  divider(context,
                      height: MediaQuery.of(context).size.height * 0.05),
                  Center(
                    child: button(context, "Salvar", () async {
                      getAllProdutos();
                      // if (await cadProd(_idProduto, int.parse(_tempo.text),
                      //     int.parse(_quantidade.text))) {
                      //   Navigator.of(context).pop();
                      // }
                    }, witdh: 0.8),
                  ),
                ]);
            break;
          default:
            return Center(child: CircularProgressIndicator());
            break;
        }
      },
    );
  }

  Widget _customDropDownExample(
      BuildContext context, String item, String itemDesignation) {
    return (item == null)
        ? Text("")
        : ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              item,
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  _container(BuildContext context, List<String> list) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08),
      child: DropdownSearch<String>(
          validator: (v) => v == null ? "required field" : null,
          label: "Selecione um Produto",
          mode: Mode.MENU,
          showSelectedItem: true,
          items: list,
          showClearButton: false,
          onChanged: (String ch) => {
                // print('teste ' + ch)
                // _idProduto = listaProdutos.keys.firstWhere(
                //     (k) => listaProdutos[k] == ch,
                //     orElse: () => null)
                _idProduto = listaProdutos
                    .firstWhere((element) => (_textFormat(element) == ch))
                    .idProduto,
                print(_idProduto)
              },
          showSearchBox: true,
          popupBackgroundColor: customBackgroundColor,
          // dropdownBuilder: _customDropDownExample,
          searchBoxDecoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Pesquisar o produto",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white10)),
              fillColor: Colors.white,
              focusColor: Colors.white),
          dropdownSearchDecoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Pesquisar o produto",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white10)),
              fillColor: Colors.white,
              focusColor: Colors.white),
          dropdownBuilder: _customDropDownExample,
          popupItemBuilder: _customPopupItemBuilderExample,
          // popupBarrierColor: Colors.red,
          popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          dropdownBuilderSupportsNullItem: true),
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, String item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: customRoxoColor),
              // borderRadius: BorderRadius.circular(5),
              color: customRoxoColor,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item),
      ),
    );
  }

  List<String> _listarSelectProdutos(List<Produtos> data) {
    var list = List<String>();
    for (var i = 0; i < data.length; i++) {
      list.add(_textFormat(data[i]));
    }
    return list;
  }

  String _textFormat(Produtos prod) {
    String text =
        prod.marca + " - " + prod.modelo + " - " + prod.kWh.toString() + " kWh";
    return text;
  }

// Widget _customPopupItemBuilderExample(
//     BuildContext context, String item, bool isSelected) {
//   return Container(
//     decoration: BoxDecoration(
//       color: customBackgroundColor,
//     ),
//     child: ListTile(
//       selected: isSelected,
//       title: Text(
//         item,
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//   );
// }
}

// _seach(BuildContext context) async {
//   // var items = await getAll();
//   return FutureBuilder(
//     future: getAll(),
//     builder: (context, snapshot) {
//       switch (snapshot.connectionState) {
//         case ConnectionState.done:
//           _container(context, snapshot.data);
//           break;
//         default:
//           return CircularProgressIndicator();
//           break;
//       }
//     },
//   );
// }
