import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget input(BuildContext context, TextEditingController controller,
    String label, String errorText,
    {String counterText,
    bool enable = true,
    TextInputType keyboardType = TextInputType.text,
    bool password = false,
    double horizontalMarge = 0.08}) {
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
