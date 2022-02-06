import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityDaysPage extends StatefulWidget {
  CityDaysPage({Key? key}) : super(key: key);

  @override
  State<CityDaysPage> createState() => _CityDaysPageState();
}

class _CityDaysPageState extends State<CityDaysPage> {
  final times = ['1', '2', '3', '4', '5', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple.shade900, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Icon(
                FontAwesomeIcons.cloud,
                color: Colors.white,
                size: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Text(
                "30\u00b0",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w100),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(
                    FontAwesomeIcons.mapMarker,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sevilla",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Today: ",
                        style: TextStyle(color: Colors.white, fontSize: 15))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("06.02.2022",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                )
              ],
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.white),
                    bottom: BorderSide(color: Colors.white)),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: times.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 60,
                      child: Card(
                        child: Center(child: Text('${times[index]}')),
                      ),
                    );
                  }),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.white),
                    bottom: BorderSide(color: Colors.white)),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: times.length,
                  itemBuilder: (context, index) {
                    return Expanded(
                      child: Container(
                        height: 60,
                        child: Card(
                          child: Center(child: Text('${times[index]}')),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
