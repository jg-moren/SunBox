import 'dart:core';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sunbox/prefabs/estilo.dart';

class PontoGraficoIrradiacao {
  final DateTime tempo;
  final double valor;

  const PontoGraficoIrradiacao(this.tempo, this.valor);
}

extension ListaGraficoExtensao on List<PontoGraficoIrradiacao> {
  FastLineSeries<PontoGraficoIrradiacao, DateTime> toSeries() {
    return FastLineSeries(
      yValueMapper: (ponto, _) => ponto.valor,
      xValueMapper: (ponto, _) => ponto.tempo,
      dataSource: this,
      color: Estilo.corSecundaria,
    );
  }
}
