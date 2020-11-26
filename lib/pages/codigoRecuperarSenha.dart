import 'package:energapp/pages/login.dart';
import 'package:energapp/pages/trocarSenha.dart';
import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/scaffold.dart';
import 'package:flutter/material.dart';

class CodigoRecuperarSenhaPage extends StatefulWidget {
  @override
  _CodigoRecuperarSenhaPageState createState() =>
      _CodigoRecuperarSenhaPageState();
}

class _CodigoRecuperarSenhaPageState extends State<CodigoRecuperarSenhaPage> {
  var _codigo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return scaffold(context, "Código", body(context), isVisibleOutLogin: false);
  }

  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        input(context, _codigo, "Código", "errorText"),
        divider(context, height: MediaQuery.of(context).size.height * 0.05),
        Center(
          child: button(
              context,
              "Recuperar Senha",
              () => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => TrocarSenhaPage()),
                        ModalRoute.withName('/'))
                  }),
        ),
      ],
    );
  }
}
