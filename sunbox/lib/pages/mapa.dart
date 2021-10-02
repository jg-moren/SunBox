import 'dart:async';

import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/prefabs/button.dart';
import 'package:sunbox/prefabs/estilo.dart';


class Mapa extends StatefulWidget {
  @override
  MapaEstado createState() => MapaEstado();

  Widget build(BuildContext context) => Scaffold();
}

class MapaEstado extends State<Mapa> {
  LatLng? _userLocation;
  LatLng? cameraPosition;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(backgroundColor: Estilo.corPrimaria, automaticallyImplyLeading: false, actions: [
        Container(
            width: MediaQuery.of(context).size.width,

            child:(cameraPosition != null)? Row(
          children: [
            Expanded(child: SizedBox()),
            Text("Coo: ${cameraPosition?.latitude.toStringAsFixed(3)}, ${cameraPosition?.longitude.toStringAsFixed(3)}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            Expanded(child: SizedBox()),
          ],
        ):null),
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

                            },
                            onMapCreated:(controller){
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
            onPressed: () => Navegacao.resultado(context, cameraPosition),
            text: Text(
              "continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
    );
  }
}
