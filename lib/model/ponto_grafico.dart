import 'dart:core';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sunbox/prefabs/estilo.dart';

class PontoGraficoIrradiacao {
  final DateTime tempo;
  final double valor;

  const PontoGraficoIrradiacao(this.tempo, this.valor);
}

extension ListaGraficoExtensao on List<PontoGraficoIrradiacao> {
  charts.Series<PontoGraficoIrradiacao, DateTime> toSeries() {
    return charts.Series(
      id: "Irradiação",
      domainFn: (ponto, _) => ponto.tempo,
      measureFn: (ponto, _) => ponto.valor,
      data: this,
      seriesColor: Estilo.corSecundariaCharts,
    );
  }
}