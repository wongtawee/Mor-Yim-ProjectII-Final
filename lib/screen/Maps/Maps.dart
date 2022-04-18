import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Set<Marker> _markers = HashSet<Marker>();
  BitmapDescriptor _markerIcon;
  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/Hoslo.jpg');
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(7.871661, 98.360499),
            infoWindow: InfoWindow(
              title: "Hospital",
              snippet: "Hospital",
            ),
            icon: _markerIcon),
      );
    });
  }

  Position userLocation;
  GoogleMapController mapController;

  Future<Position> _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(7.871661, 98.360499), zoom: 15),
              markers: _markers,
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
