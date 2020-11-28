import 'package:energapp/pages/login.dart';
import 'package:energapp/services/userService.dart';
import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/scaffold.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioPage extends StatefulWidget {
  @override
  _CadastroUsuarioPageState createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  var _email = TextEditingController();
  var _senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return scaffold(context, "Cadastro", body(context));
  }

  Widget body(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            input(context, _email, "Email", validator: validateString),
            input(context, _senha, "Senha",
                password: true, validator: validatePassword),
            divider(context, height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: button(context, "Entrar", () async {
                if (_formKey.currentState.validate()) {
                  var incluido =
                      await insert(_email.value.text, _senha.value.text);
                  if (incluido != null) {
                    await await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                }
              }),
            ),
          ],
        ));
  }
}
