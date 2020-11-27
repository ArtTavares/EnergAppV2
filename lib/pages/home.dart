import 'package:energapp/models/listaProdutoUsuario.dart';
import 'package:energapp/pages/editar.dart';
import 'package:energapp/services/produtosService.dart';
import 'package:energapp/shared/color.dart';
import 'package:energapp/shared/divider.dart';
import 'package:energapp/shared/popup.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<ListaProdutosUsuario>> listProdsUser;
  @override
  initState() {
    super.initState();
    listProdsUser = listProdUser();
  }

  double valor = 0.0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListaProdutosUsuario>>(
        future: listProdsUser,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    listProdsUser = listProdUser();
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    divider(context,
                        height: MediaQuery.of(context).size.height * 0.1),
                    Center(
                      child: Text(
                        "R\$ ${calc(snapshot.data).toStringAsFixed(2).toString().replaceAll('.', ',')}",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                    divider(context,
                        height: MediaQuery.of(context).size.height * 0.02),
                    // Center(
                    //     child: RichText(
                    //   text: TextSpan(
                    //     text: 'Bandeira: ',
                    //     style: DefaultTextStyle.of(context)
                    //         .style
                    //         .copyWith(fontSize: 25),
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //           text: 'Vermelho',
                    //           style: TextStyle(color: customRedColor)),
                    //     ],
                    //   ),
                    // )),
                    divider(context),
                    Expanded(
                      child: list(context, snapshot.data),
                    ),
                    divider(context),
                    divider(context),
                    divider(context),
                    divider(context),
                    divider(context),
                  ],
                ),
              );
              break;
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }

  list(BuildContext context, List<ListaProdutosUsuario> lista) {
    // print(lista);
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        // return rowList("Televisão Samsung xxx", "2 kWh");
        return rowList(lista[index].modelo, lista[index].kWh.toString(),
            lista[index].idDoc);
      },
    );
    // return ListView(
    //   children: [
    //     rowList("Televisão Samsung xxx", "2 kWh"),
    //     rowList("Geladeira LG xxx", "2 kWh"),
    //     rowList("Chuveiro xxx", "2 kWh")
    //   ],
    // );
  }

  rowList(String text, String kWh, String idDoc) {
    return Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Text(
                    text.length > 20 ? text.substring(0, 20) : text,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        kWh + " kWh",
                      ),
                    ),
                    VerticalDivider(),
                    iconButton(Icons.delete, customRedColor, () async {
                      // print(idDoc);
                      await deleteProdUser(idDoc);
                    }),
                    // IconButton(
                    //     icon: Icon(
                    //       Icons.delete,
                    //       color: customRedColor,
                    //     ),
                    //     iconSize: 22,
                    //     padding: EdgeInsets.all(0),
                    //     onPressed: () async {
                    //       await deleteProdUser(idDoc);
                    //     }),
                    iconButton(Icons.mode_edit, customRoxoColor, () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditarPage()));
                    }),
                  ],
                )
              ],
            ),
          ],
        ));
  }

  iconButton(IconData icon, MaterialColor color, Function() funcao) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      iconSize: 22,
      padding: EdgeInsets.all(0),
      onPressed: funcao,
    );
  }
}
