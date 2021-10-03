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
    return Scaffold(
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
                Container(
                  margin: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width*0.7,
                    height: 50,
                    child: Button.buttonMenu(
                  onPressed: () => Navegacao.result(context),
                  text: Text(
                    "New search",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
                Container(
                    margin: EdgeInsets.all(15),

                    width: MediaQuery.of(context).size.width*0.7,
                    height:50,
                    child: Button.buttonMenu(
                      onPressed: () {},
                      text: Text(
                        "My locations",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
