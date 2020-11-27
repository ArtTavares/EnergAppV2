import 'package:dropdown_search/dropdown_search.dart';
import 'package:energapp/models/produtos.dart';
import 'package:energapp/pages/tab.dart';
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
  bool isloading = false;
  bool _enable = true;
  var _tempo = TextEditingController();
  var _dias = TextEditingController();
  var _quantidade = TextEditingController();
  String _value = "padrao";
  // SingingCharacter _character = SingingCharacter.lafayette
  String _idProduto;
  var listaProdutos = new List<Produtos>();
  Future<List<Produtos>> prods;
  @override
  initState() {
    super.initState();
    prods = getAllProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Produtos>>(
      future: prods,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            listaProdutos = snapshot.data;
            return scaffold(
                context, "Adicionar Produto", body(context, snapshot.data));
            break;
          default:
            return Center(child: CircularProgressIndicator());
            break;
        }
      },
    );
    // return scaffold(context, "Add Eletrodoméstico", body(context));
  }

  Widget body(BuildContext context, List<Produtos> data) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _container(context, _listarSelectProdutos(data)),
          input(context, _tempo, "Tempo Médio Ligado", "errorText"),
          input(context, _quantidade, "Quantidade", "errorText",
              keyboardType: TextInputType.number),
          Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08, top: 20),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Quantidade de Dias',
                style: TextStyle(fontSize: 17),
              )),
          RadioListTile<String>(
            title: const Text('30 Dias'),
            value: 'padrao',
            groupValue: _value,
            onChanged: (_) {
              setState(() {
                _value = _;
                _enable = false;
              });
            },
          ),
          RadioListTile<String>(
            title: input(context, _dias, '', 'errorText',
                enable: _enable,
                keyboardType: TextInputType.number,
                horizontalMarge: 0),
            value: '2',
            groupValue: _value,
            onChanged: (_) {
              setState(() {
                _value = _;
                _enable = true;
              });
            },
          ),
          divider(context, height: MediaQuery.of(context).size.height * 0.05),
          Center(
            child: button(
              context,
              "Salvar",
              () async {
                // getAllProdutos();
                try {
                  int d = 30;
                  setState(() {
                    isloading = true;
                  });
                  if (_dias.text.isNotEmpty == null) {
                    d = double.parse(_dias.text).round();
                  }
                  if (await cadProd(
                      _idProduto,
                      double.parse(_tempo.text).round(),
                      double.parse(_quantidade.text).round(),
                      d)) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => TabPage()),
                        (Route<dynamic> route) => false);
                  }
                } catch (e) {} finally {
                  setState(() {
                    isloading = false;
                  });
                }
              },
              witdh: 0.8,
              isloading: isloading,
            ),
          ),
        ]);
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

_radio(String s, String v, String g, Null Function(String texto) test) {
  return ListTile(
    title: Text(
      s,
    ),
    leading: Radio(
      value: v,
      groupValue: g,
      activeColor: Color(0xFF6200EE),
      onChanged: test,
    ),
  );
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
