import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/controller/ControllerSalvar.dart';
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
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        backgroundColor: Estilo.corPrimaria,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          color: Estilo.corTerciaria,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Estilo.corPrimaria,
      body: Center(
        child: Container(
          padding: EdgeInsets.only( left: 20, right: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Text(
                      "My Locations",
                      style: TextStyle(color: Estilo.corSecundaria, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: "Quicksand"),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.wb_sunny,
                      color: Estilo.corSecundaria,
                    ),
                  ],
                ),
              ),
              FutureBuilder<Map<String, dynamic>>(
                  future: Salvar.pegarLocalizacoes(),
                  builder: (context, snapshot) {
                    print(snapshot.hasData);
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      Map<String, dynamic> result = snapshot.data ?? {"null": "null"};
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width,
                          child: ListView(
                            children: [
                              for (var pins in result["values"])
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  height:100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Button.buttonPin(
                                    nome: pins["nome"],
                                    endereco: pins["endereco"],
                                    onPressed: () => Navegacao.resultado(context, LatLng(pins["Lat"], pins["Lng"]),pins["endereco"],pins["nome"]),
                                  ),
                                ),
                            ],
                          ));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,

        onPressed: ()=>Navegacao.salvar(context),
        child: Icon(Icons.add,size: 20,),
      ),
    );
  }
}
