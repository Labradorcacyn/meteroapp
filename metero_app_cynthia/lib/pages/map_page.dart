import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metero_app_cynthia/pages/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late LatLng _tap;
  late SharedPreferences preferences;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    /*initPreferences().then((value) => {
          if (true) {} else {_tap = LatLng(LAT, LON)}
        });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (LatLng latlng) {
        //print(latlng.latitude);
        setState(() {
          preferences.setDouble(LAT_PREF, latlng.latitude);
          preferences.setDouble(LON_PREF, latlng.longitude);
        });
      },
    ));
  }

  Future<void> initPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
}
