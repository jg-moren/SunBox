import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunbox/prefabs/estilo.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double? y;
}

class Charts {
  static Widget grafico(Map<String, dynamic> points) {

    List<ChartData> chartData = [];

    String transformData(String value){

      String data = "${value.substring(4,6)}/${value.substring(0,4)}";
      if(value.length>6)data = "${value.substring(6,8)}/$data";
      return data;
    }

    points.forEach((key, value) => chartData.add(ChartData(key, value)));

    return SfCartesianChart(
        backgroundColor: Colors.transparent,
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
            labelRotation: 30,


            majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0),
        ),
        tooltipBehavior: TooltipBehavior(),
        primaryYAxis: NumericAxis(
            rangePadding: ChartRangePadding.round,
            majorGridLines: MajorGridLines(width: 0),
            axisLine: AxisLine(width: 0)),
        series: <CartesianSeries>[
          LineSeries<ChartData, String>(
            dataSource: chartData,
            enableTooltip: true,
            xValueMapper: (ChartData data, _) => transformData("${data.x}"),

            yValueMapper: (ChartData data, _) => data.y,
            pointColorMapper: (ChartData data, _) => Estilo.corSecundaria,
          )
        ]);
  }
}
