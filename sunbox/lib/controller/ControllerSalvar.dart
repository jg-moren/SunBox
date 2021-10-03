import 'dart:convert';

import 'package:sunbox/model/model.dart';

class Salvar {
  static void salvarLocalizacao(nome, endereco, coo) async{
    Map<String, dynamic> marker = {
      "nome": nome,
      "endereco": endereco,
      "LatLng": coo,
    };
    String old_value = await Model.getValue();
    print(old_value);
    var _marker = jsonEncode("${(old_value=="")?"":"${jsonDecode(old_value).toString()},"}${marker.toString()}");
    print(jsonEncode(marker));
    await Model.setValue(_marker);
    print((await Model.getValue()));
  }
}
