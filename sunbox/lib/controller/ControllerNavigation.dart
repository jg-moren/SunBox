import 'package:flutter/material.dart';
import '../pages/mapa.dart';
import '../pages/menu.dart';


class Navegacao{
  static void start(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
  static void novo(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Mapa()));

}