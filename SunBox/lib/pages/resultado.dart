import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunbox/controller/ControllerGrafico.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import '../model/modelValores.dart';
import 'package:sunbox/prefabs/button.dart';
import 'package:sunbox/prefabs/charts.dart';
import '../prefabs/estilo.dart';
import '../prefabs/card.dart';

class Resultado extends StatefulWidget {
  final coo;
  final String endereco;
  final String nome;

  Resultado(this.coo, this.endereco, this.nome);

  @override
  Resultado_Estado createState() => Resultado_Estado();
}

class Resultado_Estado extends State<Resultado> {
  var tipo = TemporalAverage.weekly;
  int intervaloDias = 1;

  bool loading = true;

  Widget titulo(loading) {
    return Row(children: [
      Container(
        height: 100,
        width: 300,
        margin: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.topLeft,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: const TextStyle(color: Estilo.corSecundaria, fontFamily: Estilo.fonteTexto),
            children: [
              TextSpan(
                text: (widget.nome == "") ? "Result\n" : "${widget.nome}\n",
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: widget.endereco,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      (loading)
          ? Center(
              child: CircularProgressIndicator(color: Estilo.corSecundaria),
            )
          : Container(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilo.corPrimaria,
      appBar: AppBar(
        backgroundColor: Estilo.corPrimaria,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: [
              Container(
                //margin: EdgeInsets.all(10),
                child: FutureBuilder<Map<String, dynamic>>(
                    future: ControllerGrafico.getValores(
                      tipo: tipo,
                      intervaloDias: intervaloDias,
                      coo: widget.coo,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> result = snapshot.data ?? {"null": "null"};
                        List<Widget> botoes = [
                          Button.buttonGrafico(1, "1D", intervaloDias, () => setState(() => intervaloDias = 1)),
                          Button.buttonGrafico(7, "1W", intervaloDias, () => setState(() => intervaloDias = 7)),
                          Button.buttonGrafico(30, "1M", intervaloDias, () => setState(() => intervaloDias = 30)),
                          Button.buttonGrafico(180, "6M", intervaloDias, () => setState(() => intervaloDias = 180)),
                          Button.buttonGrafico(365, "1Y", intervaloDias, () => setState(() => intervaloDias = 365)),
                          Button.buttonGrafico(3650, "10Y", intervaloDias, () => setState(() => intervaloDias = 3650)),
                        ];
                        return Column(children: [
                          titulo(snapshot.connectionState != ConnectionState.done),
                          Container(
                            height: 375,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                  child: Cartao.card(
                                    titulo: "Precipitation Corrected (W/m²)",
                                    grafico: Container(
                                      height: 250,
                                      child: Charts.grafico(result["properties"]["parameter"]["ALLSKY_SFC_PAR_TOT"]),
                                    ),
                                    botoes: botoes,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                  child: Cartao.card(
                                    titulo: "Humidity (%)",
                                    grafico: Container(
                                      height: 250,
                                      child: Charts.grafico(result["properties"]["parameter"]["RH2M"]),
                                    ),
                                    botoes: botoes,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                  child: Cartao.card(
                                    titulo: "Temperature (Cº)",
                                    grafico: Container(
                                      height: 250,
                                      child: Charts.grafico(result["properties"]["parameter"]["T2M"]),
                                    ),
                                    botoes: botoes,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]);
                      } else {
                        return Column(children: [
                          titulo(snapshot.connectionState != ConnectionState.done),
                          Container(
                            height: 375,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                              child: Cartao.card(
                                titulo: "",
                                grafico: Container(height: 250, child: Container()),
                                botoes: [],
                              ),
                            ),
                          )
                        ]);
                      }
                    }),
              ),
              Container(
                alignment: Alignment.center,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Button.botaoTemporalAverage(
                      TemporalAverage.hourly,
                      () => setState(() => tipo = TemporalAverage.hourly),
                      tipo,
                    ),
                  ),
                  Flexible(
                    child: Button.botaoTemporalAverage(
                      TemporalAverage.monthly,
                      () => setState(() => tipo = TemporalAverage.monthly),
                      tipo,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Button.botaoTemporalAverage(
                      TemporalAverage.daily,
                      () => setState(() => tipo = TemporalAverage.daily),
                      tipo,
                    ),
                  ),
                  Flexible(
                    child: Button.botaoTemporalAverage(
                      TemporalAverage.weekly,
                      () => setState(() => tipo = TemporalAverage.weekly),
                      tipo,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
