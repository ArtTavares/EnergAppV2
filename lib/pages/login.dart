import 'package:energapp/services/sharedPreferences.dart';
import 'package:energapp/services/userService.dart';
import 'package:energapp/pages/cadastroUser.dart';
import 'package:energapp/pages/recuperarSenha.dart';
import 'package:energapp/pages/tab.dart';
import 'package:energapp/shared/button.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/input.dart';
import 'package:energapp/shared/popup.dart';
import 'package:energapp/shared/scaffold.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isLoading = false;
  var _login = TextEditingController();
  var _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return scaffold(context, 'Login', body(), isVisibleOutLogin: false);
  }

  Widget body() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/veloc.png', width: 300, height: 100),
            divider(context, height: MediaQuery.of(context).size.height * 0.06),
            input(context, _login, "Email", validator: validateString),
            input(context, _password, "Senha",
                password: true, validator: validateString),
            divider(context),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(fontSize: 11),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CadastroUsuarioPage()));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "Esqueceu a senha?",
                      style: TextStyle(fontSize: 11),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RecuperarSenhaPage()));
                    },
                  ),
                ],
              ),
            ),
            divider(context, height: MediaQuery.of(context).size.height * 0.05),
            Center(
                child: button(context, "Entrar", () async {
              if (_formKey.currentState.validate()) {
                try {
                  setState(() {
                    _isLoading = true;
                  });
                  var logado = await signIn(_login.text, _password.text);
                  if (logado != null) {
                    saveId(logado.user.uid);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => TabPage()),
                        (Route<dynamic> route) => false);
                  } else {
                    alertDialogPadrao(context, 'Email ou Senha incorretos');
                  }
                } catch (e) {} finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              }
            }, isloading: _isLoading)),
            // divider(context),
            // Center(
            //   child: button(
            //       context,
            //       "Entrar Sem Login",
            //       () => {
            //             Navigator.of(context).pushReplacement(
            //                 MaterialPageRoute(builder: (context) => TabPage()))
            //           }),
            // )
          ],
        ));
  }
}
