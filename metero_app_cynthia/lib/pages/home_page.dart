import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metero_app_cynthia/pages/city_days_page.dart';
import 'package:metero_app_cynthia/pages/current_day_page.dart';
import 'package:metero_app_cynthia/pages/utils/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    CityDaysPage(),
    CurrentDayPage(),
    GoogleMap(
        initialCameraPosition: CameraPosition(
      target: LatLng(LAT, LON),
      zoom: 14.4746,
    ))
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(FontAwesomeIcons.calendarDay, size: 20),
      Icon(FontAwesomeIcons.thermometerEmpty, size: 20),
      Icon(FontAwesomeIcons.map, size: 20)
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.purple.shade100,
          color: Colors.purple,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          items: items,
          index: 1,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
