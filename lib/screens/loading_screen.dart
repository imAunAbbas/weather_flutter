import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WeatherBloc()..add(FetchLocationWeather()),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return Loading();
            }
            if (state is Failure) {
              print("Network Error!");
              return Container(
                height: 1,
                width: 1,
              );
            }
            if (state is Success) {
              return LocationScreen(weatherModel: state.weatherModel);
            }
          },
        ));
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.green,
          size: 40,
        ),
      ),
    );
  }
}
