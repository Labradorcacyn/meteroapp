import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:metero_app_cynthia/models/weather.dart';
import 'package:metero_app_cynthia/pages/utils/const.dart';
import 'package:metero_app_cynthia/pages/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentDayPage extends StatefulWidget {
  @override
  State<CurrentDayPage> createState() => _CurrentDayPageState();
}

class _CurrentDayPageState extends State<CurrentDayPage> {
  var api_key = "0c32b9ef04a238b65e65f8b87141369c";
  late Future<WeatherResponse> weath;
  late SharedPreferences preferences;

  Future<void> initPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<WeatherResponse> getWeather() async {
    var lat = PreferenceUtils.getDouble(LAT_PREF);
    var lon = PreferenceUtils.getDouble(LON_PREF);
    print('CURRENT ${PreferenceUtils.getDouble(LAT_PREF)}');

    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&units=metric&appid=${api_key}'));
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el tiempo');
    }
  }

  @override
  void initState() {
    weath = getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<WeatherResponse>(
      future: weath,
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
                        'TIEMPO EN ' + snapshot.data!.name.toUpperCase(),
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
                        "Sensación Térmica de " +
                            (snapshot.data!.main.feelsLike).toString() +
                            " \u00B0",
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
                          trailing: Text((snapshot.data!.main.temp).toString() +
                              " \u00B0")),
                      ListTile(
                          leading: FaIcon(FontAwesomeIcons.cloud),
                          title: Text("Tiempo"),
                          trailing: Text(snapshot.data!.weather[0].main)),
                      ListTile(
                          leading: FaIcon(FontAwesomeIcons.sun),
                          title: Text("Humedad"),
                          trailing: Text(
                              (snapshot.data!.main.humidity).toString() +
                                  " %")),
                      ListTile(
                          leading: FaIcon(FontAwesomeIcons.wind),
                          /*PROBANDO LA ROTACION DE LA FLECHA DEL VIENTO CON TRANSFORM
                            Transform(
                            if (snapshot.data!.wind.deg >= 90 && snapshot.data!.wind.deg < 180) {
                              transform: Matrix4.rotationZ(2),
                            }
                            if(snapshot.data!.wind.deg >= 180 && snapshot.data!.wind.deg < 200){
                              transform: Matrix4.rotationZ(5),
                            } 
                            if(snapshot.data!.wind.deg >200){
                              transform: Matrix4.rotationZ(8),)
                            }*/
                          title: Text("Velocidad del Viento"),
                          trailing: Text(
                              snapshot.data!.wind.speed.toString() + " km/h")),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.temperatureHigh,
                              color: Colors.black38,
                            ),
                            Text(
                              "Máximas: " +
                                  snapshot.data!.main.tempMax.toString() +
                                  " \u00B0    ",
                            ),
                            Icon(
                              FontAwesomeIcons.temperatureLow,
                              color: Colors.black45,
                            ),
                            Text("Mínimas: " +
                                snapshot.data!.main.tempMin.toString() +
                                " \u00B0")
                          ],
                        ),
                      ),
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
