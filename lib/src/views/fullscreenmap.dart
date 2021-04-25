import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
 
class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}
 
class _FullScreenMapState extends State<FullScreenMap> {
  static const String ACCESS_TOKEN = 'pk.eyJ1IjoiZGlsYW51cmlvc3RlZ3VpIiwiYSI6ImNrbndpdnhuYTBkeTgybnFkMXp4N2p2Y2sifQ.S23JZjYtQ4NaYOLrNmqBFQ';
 
  MapboxMapController mapController;
 
  void _onMapCreated(MapboxMapController controller){
    mapController = controller;
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: ACCESS_TOKEN,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(19.59256727290991, -99.1671063254336),
          zoom: 16.0
        ),
      )
    );
  }
}