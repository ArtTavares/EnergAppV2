// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Example of a simple line chart.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:energapp/shared/color.dart';
import 'package:flutter/material.dart';

class LinhaGraficoChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  LinhaGraficoChart(this.seriesList, {this.animate});

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory LinhaGraficoChart.withRandomData() {
    return new LinhaGraficoChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final data = [
      new LinearSales(0, random.nextInt(100)),
      new LinearSales(1, random.nextInt(100)),
      new LinearSales(2, random.nextInt(100)),
      new LinearSales(3, random.nextInt(100)),
      new LinearSales(4, random.nextInt(100)),
      new LinearSales(5, random.nextInt(100)),
      new LinearSales(6, random.nextInt(100)),
      new LinearSales(7, random.nextInt(100)),
      new LinearSales(8, random.nextInt(100)),
      new LinearSales(9, random.nextInt(100)),
      new LinearSales(10, random.nextInt(100)),
      new LinearSales(11, random.nextInt(100)),
      new LinearSales(12, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(customRoxoColor),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.white),
        data: data,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      child: new charts.LineChart(
        seriesList,
        animate: animate,
        defaultRenderer: charts.LineRendererConfig(
          includePoints: true,
        ),
      ),
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
