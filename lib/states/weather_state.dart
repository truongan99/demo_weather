import 'package:demo_weather/weather_model.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  final WeatherModel weather;
  const WeatherStateSuccess({required this.weather});
  @override
  // TODO: implement props
  List<Object?> get props => [weather];
}

class WeatherStateFailure extends WeatherState {}
