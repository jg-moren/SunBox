import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sunbox/model/model.dart';

class Salvar {
  static void salvarLocalizacao(nome, endereco, LatLng coo ) async{
    Map<String, dynamic> marker = {
      "nome": nome,
      "endereco": endereco,
      "Lat": coo.latitude,
      "Lng": coo.longitude,

    };
    var value =  await pegarLocalizacoes();
    value["values"].add(marker);
    await Model.setValue(jsonEncode(value));
    print((await Model.getValue()));
  }
  static Future<Map<String,dynamic>> pegarLocalizacoes()async{
    var json = jsonDecode(await Model.getValue());

    return  json;
  }
}
