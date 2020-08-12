import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/bloc/weather.dart';
import 'package:weather_app/constants.dart';

import '../services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchCityWeather) {
      yield* _mapFetchWeatherByCity(event.cityName);
    } else if (event is FetchLocationWeather) {
      yield* _mapFetchLocationWeather();
    }
  }

  Stream<WeatherState> _mapFetchWeatherByCity(String cityName) async* {
    try {
      yield WeatherInitial();
      http.Response response = await http
          .get('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
      if (response.statusCode == 200) {
        var weatherData = json.decode(response.body);
        WeatherModel weather = WeatherModel(
            temperature: weatherData['main']['temp'],
            cityName: weatherData['name'],
            message: weatherData['weather'][0]['description']);
        yield Success(weatherModel: weather);
      } else {
        yield Failure();
      }
    } catch (e) {
      yield Failure();
    }
  }

  Stream<WeatherState> _mapFetchLocationWeather() async* {
    try {
      yield WeatherInitial();
      Location location = Location();
      await location.getCurrentLocation();
      http.Response response = await http.get(
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
      if (response.statusCode == 200) {
        var weatherData = json.decode(response.body);
        WeatherModel weather = WeatherModel(
            temperature: weatherData['main']['temp'],
            cityName: weatherData['name'],
            message: weatherData['weather'][0]['description']);
        yield Success(weatherModel: weather);
      } else {
        yield Failure();
      }
    } catch (e) {
      yield Failure();
    }
  }
}
