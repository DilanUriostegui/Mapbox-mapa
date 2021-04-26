import 'package:flutter/material.dart';
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
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add_to_home_screen),
            onPressed: (){
              if(selectedStyle == oscuroStyle){
                selectedStyle = streetStyle;
              }
              else{
                selectedStyle = oscuroStyle;
              }
              setState(() {});
            }
          )
        ]
      ),
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