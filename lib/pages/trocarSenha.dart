import 'package:energapp/pages/login.dart';
import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/scaffold.dart';
import 'package:flutter/material.dart';

class TrocarSenhaPage extends StatefulWidget {
  @override
  _TrocarSenhaPageState createState() => _TrocarSenhaPageState();
}

class _TrocarSenhaPageState extends State<TrocarSenhaPage> {
  var _nome = TextEditingController();
  var _email = TextEditingController();
  var _senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return scaffold(context, "Recuperar Senha", body(context),
        isVisibleOutLogin: false);
  }

  Widget body(BuildContext context) {
    Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            input(context, _email, "Nova Senha",
                password: true, validator: validatePassword),
            input(context, _email, "Confirmar Nova Senha",
                password: true, validator: validatePassword),
            divider(context, height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: button(
                  context,
                  "Salvar",
                  () => {
                        if (_formKey.currentState.validate())
                          {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                ModalRoute.withName('/'))
                          }
                      }),
            ),
          ],
        ));
  }
}
