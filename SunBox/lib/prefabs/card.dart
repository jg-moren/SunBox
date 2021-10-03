import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunbox/prefabs/estilo.dart';

class Cartao {
  static Widget card({
    String? titulo,
    Widget? grafico,
    List<Widget>? botoes,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 55, 50, 50),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(10),
            child: Text(
              titulo ?? "",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            //color: Colors.red,
            child: grafico ?? Container(),
          ),
          //Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: botoes??[],
          )
        ],
      ),
    );
  }
}
