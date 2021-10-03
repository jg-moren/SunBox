import 'package:flutter/material.dart';
import 'package:sunbox/pages/result.dart';
import '../pages/mapa.dart';
import '../pages/menu.dart';

class Navegacao {
  static void start(context) => Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));

  static void novo(context) => Navigator.push(context, MaterialPageRoute(builder: (context) => Mapa()));

  static void result(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Result(0, 0, "Rua Ferreira Viana 44")));
  }
}
