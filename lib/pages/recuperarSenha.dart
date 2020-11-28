import 'package:energapp/pages/codigoRecuperarSenha.dart';
import 'package:energapp/pages/login.dart';
import 'package:energapp/services/userService.dart';
import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/scaffold.dart';
import 'package:flutter/material.dart';

class RecuperarSenhaPage extends StatefulWidget {
  @override
  _RecuperarSenhaPageState createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  var _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return scaffold(context, "Recuperar Senha", body(context),
        isVisibleOutLogin: false);
  }

  Widget body(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            input(context, _email, "Email de recuperação de senha",
                validator: validateString),
            divider(context, height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: button(context, "Recuperar Senha", () async {
                if (_formKey.currentState.validate()) {
                  await recoveryPassword(_email.text);
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
              }),
            ),
          ],
        ));
  }
}
