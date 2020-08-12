import 'package:flutter/material.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String cityName;
  String message;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = 'ERROR';
        message = 'wrong input or connection issue';
        return;
      }
      dynamic temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      message = weatherData['weather'][0]['description'];
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    var typedName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CityScreen();
                        },
                      ),
                    );
                    if (typedName != null) {
                      var weatherData = await weather.getCityWeather(typedName);
                      updateUI(weatherData);
                    }
                  },
                  child: Icon(
                    Icons.search,
                    size: 35.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$cityName',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: Theme.of(context).textTheme.display3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            'c',
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$message',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var weatherData = await weather.getLocationWeather();
          updateUI(weatherData);
        },
        tooltip: 'My Location',
        child: Icon(Icons.my_location),
      ),
    );
  }
}
