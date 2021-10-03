import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sunbox/model/modelValores.dart';
import 'package:intl/intl.dart';
import 'package:sunbox/prefabs/button.dart';

class ControllerGrafico {// 28/03/2020


  static Future<Map<String,dynamic>> getValores({required TemporalAverage tipo,required int intervaloDias,required LatLng coo})async{
    //ultima autualizacao do site
    DateTime now = new DateTime(2020,12,31);

    switch(tipo){
      case TemporalAverage.hourly:
        DateTime tempo = now.subtract(Duration(days: intervaloDias));
        String now_formatter = DateFormat('yyyyMMdd').format(now);
        String tempo_formatter = DateFormat('yyyyMMdd').format(tempo);
        return await Valores.getValorGrafico(tipo: tipo.nomeApi ,longitude: coo.longitude, latitude: coo.latitude, start: int.parse(tempo_formatter), end: int.parse(now_formatter));
      case TemporalAverage.weekly:
        /*DateTime tempo = now.subtract(Duration(days: intervaloDias));
        String now_formatter = DateFormat('yyyyMMdd').format(now);
        String tempo_formatter = DateFormat('yyyyMMdd').format(tempo);
        return await Valores.getValorGraficoSemanal(longitude: coo.longitude, latitude: coo.latitude, start: int.parse(tempo_formatter), end: int.parse(now_formatter));*/
      case TemporalAverage.daily:
        tipo = TemporalAverage.daily;
        DateTime tempo = now.subtract(Duration(days: intervaloDias));
        String now_formatter = DateFormat('yyyyMMdd').format(now);
        String tempo_formatter = DateFormat('yyyyMMdd').format(tempo);
        return await Valores.getValorGrafico(tipo: tipo.nomeApi ,longitude: coo.longitude, latitude: coo.latitude, start: int.parse(tempo_formatter), end: int.parse(now_formatter));
      case TemporalAverage.monthly:
        DateTime tempo = now.subtract(Duration(days: intervaloDias));
        String now_formatter = DateFormat('yyyy').format(now);
        String tempo_formatter = DateFormat('yyyy').format(tempo);
        return await Valores.getValorGrafico(tipo: tipo.nomeApi ,longitude: coo.longitude, latitude: coo.latitude, start: int.parse(tempo_formatter), end: int.parse(now_formatter));
    }
  }
}