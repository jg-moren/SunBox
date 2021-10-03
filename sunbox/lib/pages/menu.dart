import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/prefabs/button.dart';
import '../prefabs/estilo.dart';

class Menu extends StatefulWidget {
  @override
  Menu_Estado createState() => Menu_Estado();
}

class Menu_Estado extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Estilo.corPrimaria,
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'files/logo.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 15,),
                Container(
                    margin: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 65,
                    child: Button.buttonMenu(
                      onPressed: () => Navegacao.mapa_menu(context),
                      text: Text(
                        "New search",
                        style: TextStyle(color: Colors.white, fontFamily: "Roboto",fontSize: 17),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 65,
                    child: Button.buttonMenu(
                      onPressed: () => Navegacao.saves(context),
                      text: Text(
                        "My locations",
                        style: TextStyle(color: Colors.white,fontFamily: "Roboto",fontSize: 17),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
