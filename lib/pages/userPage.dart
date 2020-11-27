import 'package:energapp/services/userService.dart';
import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/popup.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var _email = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  _email.text = "";
                  alertDialogPadrao(context, 'Email Enviado Com Secusso');
                }
              }),
            ),
          ],
        ));
  }
}
