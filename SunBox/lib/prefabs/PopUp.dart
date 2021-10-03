import 'package:flutter/material.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/controller/ControllerSalvar.dart';

import 'estilo.dart';

class PopUp{
  static Future salvar(context, coo, endereco) async{
    String nome = "";
    await showDialog(
      context: context,
      builder: (BuildContext contex) {
        return AlertDialog(
          title: Column(
            children: [
              Text("Place name:", style: TextStyle(color: Estilo.corSecundaria)),
              TextField(
                onChanged: (text) => nome = text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Salvar.salvarLocalizacao(nome,endereco,coo);
                Navigator.pop(contex);
                Navegacao.resultado(context,coo,endereco,nome);
              },
              child: Text("Save", style: TextStyle(color: Estilo.corSecundaria)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(contex),
              child: Text("Cancel", style: TextStyle(color: Estilo.corSecundaria)),
            )
          ],
        );
      },
    );
  }

}