import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:energapp/shared/color.dart';
import 'package:flutter/material.dart';

class ColunaGraficoChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  ColunaGraficoChart(this.seriesList, {this.animate});

  factory ColunaGraficoChart.withRandomData() {
    return new ColunaGraficoChart(_createRandomData());
  }

  static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random = new Random();

    final data = [
      new OrdinalSales('Jan', random.nextInt(100)),
      new OrdinalSales('Fev', random.nextInt(100)),
      new OrdinalSales('Mar', random.nextInt(100)),
      new OrdinalSales('Abr', random.nextInt(100)),
      new OrdinalSales('Mai', random.nextInt(100)),
      new OrdinalSales('Jun', random.nextInt(100)),
      new OrdinalSales('Jul', random.nextInt(100)),
      new OrdinalSales('Ago', random.nextInt(100)),
      new OrdinalSales('Set', random.nextInt(100)),
      new OrdinalSales('Out', random.nextInt(100)),
      new OrdinalSales('Nov', random.nextInt(100)),
      new OrdinalSales('Dez', random.nextInt(100)),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(customRoxoColor),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      child: new charts.BarChart(
        seriesList,
        animate: animate,
        domainAxis: new charts.OrdinalAxisSpec(
            renderSpec: new charts.SmallTickRendererSpec(

                // Tick and Label styling here.
                labelStyle: new charts.TextStyleSpec(
                    color: charts.MaterialPalette.white),

                // Change the line colors to match text color.
                lineStyle: new charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        customBackgroundColor)))),
      ),
    );
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
