import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/model/model.dart';
import 'package:sunbox/prefabs/button.dart';
import '../prefabs/estilo.dart';
import 'package:provider/provider.dart';

class Saves extends StatefulWidget {
  @override
  Saves_Estado createState() => Saves_Estado();
}

class Saves_Estado extends State<Saves> {
  late Map<String, String> markers;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilo.corPrimaria,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 50,left: 20,right: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Text("My Locations",style: TextStyle(color: Estilo.corSecundaria,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: "Quicksand"),),
                    Expanded(child: SizedBox()),
                    Icon(Icons.wb_sunny,color: Estilo.corSecundaria,),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Container( //cria a bola verde
                margin: EdgeInsets.only(bottom: 20),
                child: TextButton(child: ClipOval(
                  child: Material(
                    color: Colors.black,
                    child: SizedBox(width: 65, height: 65, child: Icon(Icons.add, color: Colors.white,size: 30,)),//cria o icone dentro da bola verde
                  ),
                ), onPressed: () {
                  Navegacao.mapa_save(context);

                },)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
