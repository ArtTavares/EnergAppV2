import 'package:flutter/material.dart';
import 'package:energapp/shared/color.dart';

Widget button(
  BuildContext context,
  String text,
  Function funcao, {
  Color bgColor,
  Color textColor,
  double witdh = 0.9,
  double fontSize = 18,
}) {
  return Container(
    width: MediaQuery.of(context).size.width * witdh,
    height: MediaQuery.of(context).size.width * 0.11,
    child: RaisedButton(
      onPressed: funcao,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
      color: customRoxoColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.white)),
    ),
  );
}
