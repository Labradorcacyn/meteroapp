import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:metero_app_cynthia/models/weather.dart';

class CurrentDayPage extends StatefulWidget {
  @override
  State<CurrentDayPage> createState() => _CurrentDayPageState();
}

class _CurrentDayPageState extends State<CurrentDayPage> {
  var city = "sevilla";
  var api_key = "0c32b9ef04a238b65e65f8b87141369c";
  late Future<Weather> weather;
  final formKey = GlobalKey<FormState>();

  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${api_key}'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el tiempo');
    }

    /*if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }*/
  }

  @override
  void initState() {
    weather = getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    'TIEMPO EN ${city.toUpperCase()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "30 \u00B0",
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
                ),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Seleccione una ciudad"),
                        onSaved: (value) {
                          city = value.toString();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Llene este campo";
                          }
                        },
                      ),
                    )),
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
      ),
    );
  }
}
