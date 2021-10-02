import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import '../prefabs/estilo.dart';


class Tela_inicial extends StatefulWidget {
  @override
  Tela_inicial_Estado createState() => Tela_inicial_Estado();
  Widget build(BuildContext context) => Scaffold();

}

class Tela_inicial_Estado extends State<Tela_inicial> with SingleTickerProviderStateMixin{


  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }
  @override

  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  void navigationPage() {
    Navegacao.start(context);

  }

  @override
  void initState() {
    super.initState();



    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 4));
    animation = new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Estilo.corPrimaria,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 40),

                child:new Image.asset(
                  'files/logo.png',
                  width: 150,
                  height: 150,
                ),

              ),

            ],
          ),
        ],
      ),
    );
  }
}