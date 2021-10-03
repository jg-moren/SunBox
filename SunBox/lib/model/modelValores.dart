import 'package:http/http.dart' as http;
import 'dart:convert';

class Valores {
  static Future<Map<String, dynamic>> getValorGrafico(
      {required String tipo,
      required double longitude,
      required double latitude,
      required int start,
      required int end}) async {
    String url =
        "https://power.larc.nasa.gov/api/temporal/$tipo/point?parameters=$parametro1,$parametro2,$parametro3&longitude=$longitude&latitude=$latitude&start=$start&end=$end&community=RE&format=JSON";
    print(url);
    var response = await http.get(Uri.parse("${url}"));
    var result = jsonDecode(response.body);
    return result;
  }

  static Future<Map<String, dynamic>> getValorGraficoSemanal({
    required double longitude,
    required double latitude,
    required int start,
    required int end,
  }) async {
    String url =
        "https://power.larc.nasa.gov/api/temporal/daily/point?parameters=$parametro1,$parametro2,$parametro3&longitude=$longitude&latitude=$latitude&start=$start&end=$end&community=RE&format=JSON";
    print(url);
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    Map<String, dynamic> result = json.decode(response.body);
    int atual = 1;
    var ultimaKey = "";
    final Map<String, dynamic> res = [parametro1, parametro2, parametro3].fold<Map<String, dynamic>>(
      {},
      (acc, parametro) {
        acc["properties"]["parameter"][parametro] = result.entries.fold<Map<String, double>>({}, (acc, me) {
          switch (atual) {
            case 1:
              acc[me.key] = me.value;
              ultimaKey = me.key;
              break;
            case 7:
              acc[ultimaKey] = (acc[ultimaKey]! + me.value) / 7;
              atual = 0;
              break;
            default:
              acc[ultimaKey] = acc[ultimaKey]! + me.value;
              break;
          }
          atual++;
          return acc;
        });
        return acc;
      },
    );
    print(res);
    return res;
  }

  static const parametro1 = "ALLSKY_SFC_PAR_TOT";
  static const parametro2 = "RH2M";
  static const parametro3 = "T2M";
}
