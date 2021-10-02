import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/prefabs/button.dart';
import '../prefabs/estilo.dart';

class Saves extends StatefulWidget {
  @override
  Saves_Estado createState() => Saves_Estado();
}

class Saves_Estado extends State<Saves> {
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
            ],
          ),
        ),
      ),
    );
  }
}
