import 'dart:async';
import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/prefabs/button.dart';
import 'package:sunbox/prefabs/estilo.dart';
import 'package:geocode/geocode.dart';
import 'package:http/http.dart' as http;
import '../prefabs/PopUp.dart';

class Mapa extends StatefulWidget {
  final salvar;

  Mapa(this.salvar);

  @override
  MapaEstado createState() => MapaEstado();

  Widget build(BuildContext context) => Scaffold();
}

class MapaEstado extends State<Mapa> {
  String? endereco;

  LatLng? _userLocation;
  LatLng? cameraPosition;

  @override
  void initState() {
    super.initState();
  }


  Future<String> getAddress (LatLng coo) async{
    var request = await http.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${coo.latitude},${coo.longitude}&key=AIzaSyB9csyOpY1min9iwx5_0M_Sex32vs4eJMo"));
    var adress = jsonDecode(request.body);
    return adress["results"][0]["formatted_address"];
  }
  @override
  Future<bool>? getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    final result = await location.getLocation();
    _userLocation = LatLng(result.latitude ?? 0, result.longitude ?? 0);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Estilo.corPrimaria, actions: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: (cameraPosition != null)
                ? Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              child:
                Text(" ${endereco??""}",overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            )
                : null),
      ]),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  FutureBuilder(
                    future: getUserLocation(),
                    builder: (context, snapshot) {
                      switch (snapshot.hasData && snapshot.data == true) {
                        case true:
                          return GoogleMap(
                            mapType: MapType.normal,
                            onCameraMove: (_cameraPosition) {
                              setState(() {
                                cameraPosition = _cameraPosition.target;
                              });
                            },
                            onCameraIdle: () async {
                              endereco = await getAddress(cameraPosition!);
                              print("endereco ${cameraPosition}");
                            },
                            onMapCreated: (controller) {
                              setState(() {
                                cameraPosition = _userLocation;
                              });
                            },
                            initialCameraPosition: CameraPosition(
                              target: _userLocation ?? LatLng(-22.9331, -43.1774),
                            ),
                            myLocationEnabled: true,
                          );
                        default:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                      }
                    },
                  ),
                  Container(
                    //margin: const EdgeInsets.only(top: 300),
                    alignment: Alignment(0, -0.1),
                    child: Image.asset("files/pin.png", scale: 10),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: Estilo.corPrimaria,
        child: Button.buttonMenu(
            onPressed: () {
              if (widget.salvar) {
                PopUp.salvar(context,cameraPosition,endereco);
              } else {
                Navegacao.resultado(context, cameraPosition,endereco,"");
              }
            },
            text: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
    );
  }
}
