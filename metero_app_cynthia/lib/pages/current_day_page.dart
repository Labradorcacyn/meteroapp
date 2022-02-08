import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:metero_app_cynthia/models/weather.dart';
import 'package:metero_app_cynthia/pages/utils/const.dart';

class CurrentDayPage extends StatefulWidget {
  @override
  State<CurrentDayPage> createState() => _CurrentDayPageState();
}

class _CurrentDayPageState extends State<CurrentDayPage> {
  var api_key = "0c32b9ef04a238b65e65f8b87141369c";
  late Future<WeatherResponse> weather;

  Future<WeatherResponse> getWeather() async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${LAT.toString()}&lon=${LON.toString()}&appid=${api_key}'));
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el tiempo');
    }
  }

  @override
  void initState() {
    weather = getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<WeatherResponse>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data!.main);
          return Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.purple.shade900, Colors.white])),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'TIEMPO',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      (snapshot.data!.main.temp).toString() + " \u00B0",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Rain",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                          leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                          title: Text("Temperatura"),
                          trailing: Text("52\u00B0")),
                      ListTile(
                          leading: FaIcon(FontAwesomeIcons.cloud),
                          title: Text("Tiempo"),
                          trailing: Text("Tiempo")),
                      ListTile(
                          leading: FaIcon(FontAwesomeIcons.sun),
                          title: Text("Humedad"),
                          trailing: Text("12")),
                      ListTile(
                          leading: FaIcon(FontAwesomeIcons.wind),
                          title: Text("Velocidad del Viento"),
                          trailing: Text("12"))
                    ],
                  ),
                ),
              )
            ],
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
