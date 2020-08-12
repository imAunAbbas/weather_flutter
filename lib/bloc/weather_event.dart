part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class FetchLocationWeather extends WeatherEvent {}

class FetchCityWeather extends WeatherEvent {
  final String cityName;

  FetchCityWeather({@required this.cityName});
}
