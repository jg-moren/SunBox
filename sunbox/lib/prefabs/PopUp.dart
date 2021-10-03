import 'package:flutter/material.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/controller/ControllerSalvar.dart';

class PopUp{
  static Future salvar(context, coo, endereco) async{
    String nome = "";
    await showDialog(
      context: context,
      builder: (BuildContext contex) {
        return AlertDialog(
          title: Column(
            children: [
              Text("Nome do Local"),
              TextField(
                onChanged: (text) => nome = text,
              ),
            ],
          ),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(contex),
              child: Text("Skip"),
            ),
            TextButton(
              onPressed: () {
                Salvar.salvarLocalizacao(nome,endereco,coo);
                Navigator.pop(contex);
                Navegacao.resultado(context,coo);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

}