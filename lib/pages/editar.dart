import 'package:energapp/models/produtosUsuario%20.dart';
import 'package:energapp/pages/tab.dart';
import 'package:energapp/services/produtosService.dart';
import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/scaffold.dart';
import 'package:flutter/material.dart';

class EditarPage extends StatefulWidget {
  final String idDoc;
  final String prod;
  EditarPage({Key key, @required this.idDoc, @required this.prod})
      : super(key: key);
  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {
  ProdutosUsuario produtosUsuario;
  final _formKey = GlobalKey<FormState>();
  var _dias = TextEditingController();
  var _tempo = TextEditingController();
  var _quantidade = TextEditingController();
  var _pesquisa = TextEditingController();
  String _value = "padrao";
  bool isloading = false;
  bool _enable = true;

  @override
  initState() {
    super.initState();
    setInput();
  }

  setInput() async {
    produtosUsuario = await getProdUser(widget.idDoc);
    setState(() {
      _tempo.text = produtosUsuario.tempo.toString();
      _pesquisa.text = widget.prod;
      _quantidade.text = produtosUsuario.quantidade.toString();
      if (produtosUsuario.dias != 30) {
        _dias.text = produtosUsuario.dias.toString();
        _value = '2';
      } else {
        _value = 'padrao';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(context, "Editar", body(context));
  }

  Widget body(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              input(context, _pesquisa, "Produto", enable: false),
              input(context, _tempo, "Tempo médio ligado em horas"),
              input(context, _quantidade, "Quantidade",
                  keyboardType: TextInputType.number),
              Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.08, top: 20),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Número de dias com o produto ligado',
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
                title: input(context, _dias, '',
                    enable: _enable,
                    keyboardType: TextInputType.number,
                    horizontalMarge: 0,
                    validator: validateDias),
                value: '2',
                groupValue: _value,
                onChanged: (_) {
                  setState(() {
                    _value = _;
                    _enable = true;
                  });
                },
              ),
              divider(context,
                  height: MediaQuery.of(context).size.height * 0.05),
              Center(
                child: button(
                  context,
                  "Salvar",
                  () async {
                    // getAllProdutos();
                    if (_formKey.currentState.validate()) {
                      try {
                        int d = 30;
                        setState(() {
                          isloading = true;
                        });
                        if (_dias.text.isNotEmpty == null) {
                          d = double.parse(_dias.text).round();
                        }
                        await editProd(
                            widget.idDoc,
                            produtosUsuario.idproduto,
                            double.parse(_tempo.text).round(),
                            double.parse(_quantidade.text).round(),
                            d);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => TabPage()),
                            (Route<dynamic> route) => false);
                      } catch (e) {} finally {
                        setState(() {
                          isloading = false;
                        });
                      }
                    }
                  },
                  witdh: 0.8,
                  isloading: isloading,
                ),
              ),
              // Center(
              //   child: button(
              //       context,
              //       "Salvar",
              //       () => {
              //             if (_formKey.currentState.validate())
              //               {Navigator.of(context).pop()}
              //           },
              //       witdh: 0.8),
              // ),
            ]));
  }

  String validateDias(String value) {
    if (_value == '2' && value.isEmpty) {
      return 'Campo não pode ser vazio';
    } else if (int.tryParse(value) == null) {
      return 'Esse é um campo numérico';
    } else if (int.tryParse(value) > 30) {
      return 'Campo não pode ser maior que 30';
    }
    return null;
  }
}
