import 'package:demo_weather/weather_event.dart';
import 'package:demo_weather/weather_repositorie.dart';
import 'package:demo_weather/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepositories weatherRepositories;
  WeatherBloc({required this.weatherRepositories})
      : super(WeatherStateInitial());
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: implement mapEventToState
    if (event is WeatherEventRequest) {
      yield WeatherStateLoading();
      try {
        final weather =
            await weatherRepositories.fetchWeathers(event.lat, event.lng);
        yield WeatherStateSuccess(weather: weather);
      } catch (e) {
        print(e);
        yield WeatherStateFailure();
      }
    }
  }
}
