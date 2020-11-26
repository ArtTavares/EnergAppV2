import 'package:energapp/shared/color.dart';
import 'package:flutter/material.dart';

Future<Widget> alertDialogPadrao(BuildContext context, String labelMenssagem,
    {Color backgroundColor}) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor ?? customBackgroundColor,
          title: Center(
            child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Icon(
                    Icons.warning,
                    size: 40.0,
                    color: customFontColor,
                  )),
              Center(
                  child: Text(
                'Atenção',
                style: TextStyle(color: customFontColor),
              )),
            ]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  labelMenssagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: customFontColor,
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              FlatButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: customFontColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              Divider(),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        );
      });
}

Future<T> alertDialogPadraoF<T>(
    BuildContext context, String labelMenssagem, Function functionThen,
    {Color backgroundColor, Color colorFont}) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor ?? Color.fromRGBO(248, 221, 39, 1),
          title: Center(
            child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Icon(
                    Icons.warning,
                    size: 40.0,
                    color: colorFont ?? customFontColor,
                  )),
              Center(
                  child: Text(
                'Atenção',
                style: TextStyle(color: colorFont ?? customFontColor),
              )),
            ]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  labelMenssagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorFont ?? customFontColor,
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              FlatButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: colorFont ?? customFontColor),
                  ),
                  onPressed: () {
                    functionThen();
                  }),
              Divider(),
              FlatButton(
                  child: Text(
                    'Suporte Online',
                    style: TextStyle(color: colorFont ?? customFontColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context, "");
                  }),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        );
      });
}
