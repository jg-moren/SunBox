import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sunbox/prefabs/estilo.dart';
import 'package:sunbox/model/ponto_grafico.dart';

class Result extends StatefulWidget {
  final double latitude, longitude;
  final String endereco;

  const Result(this.latitude, this.longitude, this.endereco, {Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var indexBotaoPeriodo = 4;
  var periodo = Periodo.semana1;
  var indexBotaoTemporalAverage = 2;
  var temporalAverage = TemporalAverage.weekly;

  _ResultState() : super();

  Widget botaoPeriodo(int id, Periodo valor) {
    return TextButton(
      onPressed: () => setState(() {
        indexBotaoPeriodo = id;
        periodo = valor;
      }),
      child: Text(
        valor.nome,
        style: TextStyle(
          color: id == indexBotaoPeriodo ? Estilo.corSecundaria : Estilo.corTerciaria,
          fontFamily: Estilo.fonteBotao,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget botaoTemporalAverage(int id, TemporalAverage valor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: TextButton(
        onPressed: () => setState(() {
          indexBotaoTemporalAverage = id;
          temporalAverage = valor;
        }),
        style: TextButton.styleFrom(
          backgroundColor: id == indexBotaoTemporalAverage ? Estilo.corTerciaria : Estilo.corPrimaria,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
          side: const BorderSide(color: Estilo.corTerciaria),
        ),
        child: Container(
          height: 20,
          width: 140,
          child: Center(
            child: Text(
              valor.nome,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Estilo.fonteBotao,
                fontSize: 14,
                color: id != indexBotaoTemporalAverage ? Estilo.corTerciaria : Estilo.corPrimaria,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Estilo.corPrimaria,
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        shadowColor: Color(0x00000000),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Estilo.corPrimaria,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: const TextStyle(color: Estilo.corSecundaria, fontFamily: Estilo.fonteTexto),
              children: <InlineSpan>[
                const TextSpan(
                  text: "Result\n",
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: widget.endereco,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          // O Gráfico
          Flexible(
            child: Center(
              child: Container(
                height: 245,
                width: 350,
                child: Card(
                  color: Color(0xff383333),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Column(children: [
                      Expanded(
                        child: charts.TimeSeriesChart(
                          [
                            [
                              PontoGraficoIrradiacao(DateTime.now(), 200),
                              PontoGraficoIrradiacao(DateTime(2020, 20, 10), 100),
                              PontoGraficoIrradiacao(DateTime(2019, 20, 10), 90),
                              PontoGraficoIrradiacao(DateTime(2018, 20, 10), 110),
                            ].toSeries(),
                          ],
                          behaviors: [
                            charts.SeriesLegend(
                              showMeasures: true,
                              entryTextStyle: charts.TextStyleSpec(
                                color: Estilo.corSecundariaCharts,
                                fontFamily: Estilo.fonteBotao,
                              ),
                            ),
                            //charts.ChartBehavior()
                          ],
                        ),
                      ),
                      Row(children: []),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: const Text(
              "Temporal Average:",
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontFamily: Estilo.fontePadrao,
                fontSize: 19,
                color: Estilo.corSecundaria,
              ),
            ),
          ),
          Row(children: [
            Flexible(child: botaoTemporalAverage(0, TemporalAverage.hourly)),
            Flexible(child: botaoTemporalAverage(1, TemporalAverage.daily)),
          ]),
          Row(children: [
            Flexible(child: botaoTemporalAverage(2, TemporalAverage.weekly)),
            Flexible(child: botaoTemporalAverage(3, TemporalAverage.monthly)),
          ]),
        ]),
      ),
    );
  }
}

enum Periodo { dia1, semana1, mes1, mes6, ano1, ano10 }

extension PeriodoExtensao on Periodo {
  String get nome {
    switch (this) {
      case Periodo.dia1:
        return "1D";
      case Periodo.semana1:
        return "1W";
      case Periodo.mes1:
        return "1M";
      case Periodo.mes6:
        return "6M";
      case Periodo.ano1:
        return "1Y";
      case Periodo.ano10:
        return "10Y";
    }
  }
}

enum TemporalAverage { hourly, daily, weekly, monthly }

extension TemporalAverageExtensao on TemporalAverage {
  String get nome {
    switch (this) {
      case TemporalAverage.hourly:
        return "Hourly";
      case TemporalAverage.daily:
        return "Daily";
      case TemporalAverage.weekly:
        return "Weekly";
      case TemporalAverage.monthly:
        return "Monthly";
    }
  }
}
