import 'package:flutter/material.dart';
import 'package:sunbox/pages/resultado.dart';
import 'package:sunbox/pages/saves.dart';
import '../pages/mapa.dart';
import '../pages/menu.dart';


class Navegacao{
  static void start(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
  static void novo(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Mapa(true)));
  static void resultado(context,coo)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Resultado(coo)));
  static void saves(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Saves()));
  static void salvar(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Mapa(true)));


}