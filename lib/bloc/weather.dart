import 'package:flutter/material.dart';

class WeatherModel {
  final dynamic temperature;
  final String cityName;
  final String message;

  WeatherModel(
      {@required this.temperature,
      @required this.cityName,
      @required this.message});
}
