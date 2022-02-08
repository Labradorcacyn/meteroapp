import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:metero_app_cynthia/models/one_call.dart';
import 'package:metero_app_cynthia/pages/utils/const.dart';

class CityDaysPage extends StatefulWidget {
  CityDaysPage({Key? key}) : super(key: key);

  @override
  State<CityDaysPage> createState() => _CityDaysPageState();
}

class _CityDaysPageState extends State<CityDaysPage> {
  final times = ['1', '2', '3', '4', '5', '2', '3', '4', '5'];
  var api_key = "0c32b9ef04a238b65e65f8b87141369c";
  late Future<OneCallResponse> oneCall;

  @override
  void initState() {
    oneCall = getOneCall();
    super.initState();
  }

  Future<OneCallResponse> getOneCall() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${LAT.toString()}&lon=${LON.toString()}&exclude=minutely,current,alerts&appid=${api_key}'));
    if (response.statusCode == 200) {
      return OneCallResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el tiempo');
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: FutureBuilder<OneCallResponse>(
        future: oneCall,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Today: ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("06.02.2022",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
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
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
