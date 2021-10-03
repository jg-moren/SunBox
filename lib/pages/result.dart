import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sunbox/prefabs/estilo.dart';
import 'package:sunbox/model/ponto_grafico.dart';
import 'package:intl/intl.dart';

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
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: TextButton(
        onPressed: () => setState(() {
          indexBotaoPeriodo = id;
          periodo = valor;
        }),
        child: SizedBox(
          width: 20,
          child: Text(
            valor.nome,
            style: TextStyle(
              color: id == indexBotaoPeriodo ? Estilo.corSecundaria : Estilo.corTerciaria,
              fontFamily: Estilo.fonteBotao,
              fontSize: 10,
            ),
          ),
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
                      Flexible(
                        child: SfCartesianChart(
                          primaryXAxis: DateTimeAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            majorTickLines: const MajorTickLines(color: Estilo.corTerciaria),
                            axisLine: const AxisLine(color: Estilo.corTerciaria),
                            labelStyle: const TextStyle(color: Estilo.corSecundaria),
                          ),
                          primaryYAxis: NumericAxis(
                            axisLine: const AxisLine(color: Estilo.corTerciaria),
                            majorTickLines: const MajorTickLines(color: Estilo.corTerciaria),
                            majorGridLines: const MajorGridLines(width: 0.5),
                            labelStyle: const TextStyle(color: Estilo.corSecundaria),
                          ),
                          series: [
                            [
                              PontoGraficoIrradiacao(DateTime.now(), 200),
                              PontoGraficoIrradiacao(DateTime(2020, 10, 20), 180),
                              PontoGraficoIrradiacao(DateTime(2019, 10, 20), 140),
                              PontoGraficoIrradiacao(DateTime(2018, 10, 20), 110),
                              PontoGraficoIrradiacao(DateTime(2017, 10, 20), 190),
                              PontoGraficoIrradiacao(DateTime(2017, 5, 20), 100),
                            ].toSeries()
                          ],
                          title: ChartTitle(
                            text: "Irradiation",
                            textStyle: TextStyle(
                              fontFamily: Estilo.fonteTexto,
                              fontSize: 16,
                              color: Estilo.corSecundaria,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(child: botaoPeriodo(0, Periodo.dia1)),
                            Flexible(child: botaoPeriodo(1, Periodo.semana1)),
                            Flexible(child: botaoPeriodo(2, Periodo.mes1)),
                            Flexible(child: botaoPeriodo(3, Periodo.mes6)),
                            Flexible(child: botaoPeriodo(4, Periodo.ano1)),
                            Flexible(child: botaoPeriodo(5, Periodo.ano10)),
                          ],
                        ),
                      ),
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
