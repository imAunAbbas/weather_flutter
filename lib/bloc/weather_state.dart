part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class Failure extends WeatherState {}

class Success extends WeatherState {
  final WeatherModel weatherModel;

  Success({@required this.weatherModel});
}
