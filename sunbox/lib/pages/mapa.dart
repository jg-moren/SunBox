import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

import 'package:sunbox/prefabs/button.dart';
import '../prefabs/estilo.dart';

class Mapa extends StatefulWidget {
  @override
  Mapa_Estado createState() => Mapa_Estado();
}

class Mapa_Estado extends State<Mapa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Estilo.corPrimaria,
        body: Center(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(10,10)),
          )
        ));
  }
}
