import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metero_app_cynthia/pages/utils/const.dart';
import 'package:metero_app_cynthia/pages/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late LatLng _tap;

  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();
    print('MAP ${PreferenceUtils.getDouble(LAT_PREF)}');

    if (PreferenceUtils.getDouble(LAT_PREF) == null ||
        PreferenceUtils.getDouble(LON_PREF) == null) {
      _kGooglePlex = CameraPosition(
        target: LatLng(37.3826, -5.99629),
        zoom: 14.4746,
      );
    }
    if (PreferenceUtils.getDouble(LAT_PREF) != null ||
        PreferenceUtils.getDouble(LON_PREF) != null) {
      _kGooglePlex = CameraPosition(
        target: LatLng(PreferenceUtils.getDouble(LAT_PREF)!,
            PreferenceUtils.getDouble(LON_PREF)!),
        zoom: 14.4746,
      );
    }
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
        setState(() {
          _tap = latlng;
        });
        PreferenceUtils.setDouble(LAT_PREF, latlng.latitude);
        PreferenceUtils.setDouble(LON_PREF, latlng.longitude);
      },
      markers: <Marker>{_createMarker()},
    ));
  }

  Marker _createMarker() {
    return Marker(
      markerId: MarkerId("marker_1"),
      position: LatLng(PreferenceUtils.getDouble(LAT_PREF)!,
          PreferenceUtils.getDouble(LON_PREF)!),
    );
  }
}
