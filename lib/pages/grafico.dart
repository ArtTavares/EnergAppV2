import 'package:energapp/pages/linhaGrafico.dart';
import 'package:energapp/shared/color.dart';
import 'package:flutter/material.dart';

import 'colunaGrafico.dart';

class GraficoPage extends StatefulWidget {
  @override
  _GraficoPageState createState() => _GraficoPageState();
}

class _GraficoPageState extends State<GraficoPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: ColunaGraficoChart.withRandomData(),
          ),
          Divider(
            color: customRoxoColor,
            thickness: 4,
          ),
          Container(
            child: LinhaGraficoChart.withRandomData(),
          )
        ],
      ),
    );
  }
}
