import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/scaffold.dart';
import 'package:flutter/material.dart';

class EditarPage extends StatefulWidget {
  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {
  var _tempo = TextEditingController();
  var _quantidade = TextEditingController();
  var _pesquisa = TextEditingController(text: "TV Samsung");
  @override
  Widget build(BuildContext context) {
    return scaffold(context, "Editar", body(context));
  }

  Widget body(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          input(context, _pesquisa, "Produto", "errorText", enable: false),
          input(context, _tempo, "Tempo Médio Ligado", "errorText"),
          input(context, _quantidade, "Quantidade", "errorText",
              keyboardType: TextInputType.number),
          divider(context, height: MediaQuery.of(context).size.height * 0.05),
          Center(
            child: button(
                context, "Salvar", () => {Navigator.of(context).pop()},
                witdh: 0.8),
          ),
        ]);
  }
}
