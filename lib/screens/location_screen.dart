import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherModel});

  final WeatherModel weatherModel;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
                    BlocProvider.of<WeatherBloc>(context)
                        .add(FetchCityWeather(cityName: typedName));
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
                      '${widget.weatherModel.cityName}',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '${widget.weatherModel.temperature.toInt()}°',
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
                      '${widget.weatherModel.message}',
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
          BlocProvider.of<WeatherBloc>(context).add(FetchLocationWeather());
        },
        tooltip: 'My Location',
        child: Icon(Icons.my_location),
      ),
    );
  }
}
