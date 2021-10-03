import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sunbox/prefabs/estilo.dart';

class Button {
  static Widget buttonMenu({@required onPressed, text, height, width}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: Estilo.corSecundaria,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          )),
      child: text ?? null,
    );
  }

  static Widget buttonGrafico(int intervaloDias, String nome, int valorSelecionado, onPressed) {
    return Container(
      height: 50,
      width: 40,
      //margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          //backgroundColor: Colors.red,
        ),
        onPressed: onPressed,
        child: Text(
          nome,
          style: TextStyle(
            color: intervaloDias == valorSelecionado ? Estilo.corSecundaria : Estilo.corTerciaria,
            fontFamily: Estilo.fonteBotao,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static Widget botaoTemporalAverage(TemporalAverage tipo, void Function() onPressed, TemporalAverage tipoSelecionado) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: tipo == tipoSelecionado ? Estilo.corTerciaria : Estilo.corPrimaria,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
          side: const BorderSide(color: Estilo.corTerciaria),
        ),
        child: Container(
          height: 20,
          width: 140,
          child: Center(
            child: Text(
              tipo.nome,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Estilo.fonteBotao,
                fontSize: 14,
                color: tipo != tipoSelecionado ? Estilo.corTerciaria : Estilo.corPrimaria,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buttonPin({@required onPressed, String? nome, String? endereco, coo}) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      onPressed: onPressed,
      child: Container(
        child: ListTile(
          title: Text(
            nome ?? "",
            style: TextStyle(
              color: Estilo.corTerciaria,
              fontFamily: Estilo.fontePadrao,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            endereco ?? "",
            style: TextStyle(
              color: Estilo.corTerciaria,
              fontFamily: Estilo.fontePadrao,
              fontSize: 15,
            ),
          ),
          trailing: Icon(Icons.arrow_back),
        ),
      ),
    );
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

  String get nomeApi {
    switch (this) {
      case TemporalAverage.hourly:
        return "hourly";
      case TemporalAverage.daily:
        return "daily";
      case TemporalAverage.weekly:
        return "weekly";
      case TemporalAverage.monthly:
        return "monthly";
    }
  }
}
