import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
 
class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}
 
class _FullScreenMapState extends State<FullScreenMap> {
  static const String ACCESS_TOKEN = 'pk.eyJ1IjoiZGlsYW51cmlvc3RlZ3VpIiwiYSI6ImNrbndpdnhuYTBkeTgybnFkMXp4N2p2Y2sifQ.S23JZjYtQ4NaYOLrNmqBFQ';
 
  MapboxMapController mapController;

  final center = LatLng(19.59256727290991, -99.1671063254336);
  final oscuroStyle = 'mapbox://styles/dilanuriostegui/cknysyi1a48l917rh22kiapk0';
  final streetStyle = 'mapbox://styles/dilanuriostegui/cknyt0r9r2yke17qensclt3cp';
  String selectedStyle = 'mapbox://styles/dilanuriostegui/cknysyi1a48l917rh22kiapk0';


  void _onMapCreated(MapboxMapController controller){
    mapController = controller;
    _onStyleLoaded();
  }

   void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", Uri.parse("https://via.placeholder.com/50"));
  }


  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }


  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController.addImage(name, response.bodyBytes);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [


        //Simbolos
        FloatingActionButton(
          child: Icon(Icons.sentiment_very_dissatisfied),
          onPressed: (){
            mapController.addSymbol(SymbolOptions(
              geometry: center,
              //iconSize: 3,
              iconImage: 'networkImage',
              textField: 'Montaña creada aqui',
              textOffset: Offset(0, 2)
            ));
          }
        ),

        SizedBox(height: 5),


        //Zoom in
        FloatingActionButton(
          child: Icon(Icons.zoom_in),
          onPressed: (){
            mapController.animateCamera( CameraUpdate.zoomIn() );
          }
        ),

        SizedBox(height: 5),

        //Zoom out
        FloatingActionButton(
          child: Icon(Icons.zoom_out),
          onPressed: (){
            mapController.animateCamera( CameraUpdate.zoomOut() );
          }
        ),


        //Cambiar estilo
        FloatingActionButton(
          child: Icon(Icons.add_to_home_screen),
          onPressed: (){
            if(selectedStyle == oscuroStyle){
              selectedStyle = streetStyle;
            }
            else{
              selectedStyle = oscuroStyle;
            }
            _onStyleLoaded();
            setState(() {});
          }
        )
      ]
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      accessToken: ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 16.0
      ),
    );
  }
}