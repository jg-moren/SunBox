import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/prefabs/button.dart';
import '../prefabs/estilo.dart';

class Resultado extends StatefulWidget {
  final coo;
  Resultado(this.coo);

  @override
  Resultado_Estado createState() => Resultado_Estado();
}

class Resultado_Estado extends State<Resultado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilo.corPrimaria,
      body: Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

          ]),
        ),
      ),
    );
  }
}
