import 'dart:convert';

import 'package:demo_weather/weather_model.dart';
import 'package:http/http.dart' as http;

final API_KEY = '700e1f9414cc7750adcc477e8abd104d';
final getWeatherAPI = (double lat, double lng) =>
    'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=minutely,hourly&appid=$API_KEY';
Map<String, String> headers = {
  'Content-Type': 'application/json;charset=UTF-8',
  'Charset': 'utf-8'
};

class WeatherRepositories {
  final http.Client httpClient;
  WeatherRepositories({required this.httpClient});

  Future<WeatherModel> fetchWeathers(double lat, double lng) async {
    print(Uri.parse(getWeatherAPI(lat, lng)));
    final response = await this
        .httpClient
        .get(Uri.parse(getWeatherAPI(lat, lng)), headers: headers);
    if (response.statusCode == 200) {
      return WeatherModel.fromMap(json.decode(response.body));
    } else {
      print('Get weather fail');
      throw Exception('Get weather fail');
    }
  }
}
