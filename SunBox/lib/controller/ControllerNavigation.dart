import 'package:flutter/material.dart';
import 'package:sunbox/pages/resultado.dart';
import 'package:sunbox/pages/saves.dart';
import '../pages/mapa.dart';
import '../pages/menu.dart';


class Navegacao{
  static void start(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
  static void novo(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Mapa(false)));
  static void resultado(context,coo,endereco,nome)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Resultado(coo,endereco,nome)));
  static void saves(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Saves()));
  static void salvar(context)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Mapa(true)));


}