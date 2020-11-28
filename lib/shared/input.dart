import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget input(
    BuildContext context, TextEditingController controller, String label,
    {String counterText,
    bool enable = true,
    TextInputType keyboardType = TextInputType.text,
    bool password = false,
    double horizontalMarge = 0.08,
    String Function(String) validator}) {
  return Container(
    margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * horizontalMarge),
    child: Column(
      children: [
        TextFormField(
          obscureText: password,
          keyboardType: keyboardType,
          style: TextStyle(color: Colors.white),
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              enabled: enable,
              counterText: counterText,
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
        ),
      ],
    ),
  );
}

String validateString(String value) {
  if (value.isEmpty) {
    return 'Campo não pode ser vazio';
  }
  return null;
}

String validateNumber(String value) {
  if (value.isEmpty) {
    return 'Campo não pode ser vazio';
  } else if (int.tryParse(value) == null) {
    return 'Esse é um campo numérico';
  }
  return null;
}

String validateDouble(String value) {
  if (value.isEmpty) {
    return 'Campo não pode ser vazio';
  } else if (double.tryParse(value) == null) {
    return 'Esse é um campo numérico';
  }
  return null;
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return 'Campo não pode ser vazio';
  } else if (value.length < 6) {
    return 'Mínimo de 6 caractéres';
  }
  return null;
}