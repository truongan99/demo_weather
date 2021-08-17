import 'dart:async';

import 'package:demo_weather/blocs/weather_bloc.dart';
import 'package:demo_weather/blocs/weather_bloc_observer.dart';
import 'package:demo_weather/events/weather_event.dart';
import 'package:demo_weather/models/weather_model.dart';
import 'package:demo_weather/repositories/weather_repositorie.dart';
import 'package:demo_weather/states/weather_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepositories weatherRepositories =
      WeatherRepositories(httpClient: http.Client());
  runApp(MyApp(weatherRepositories: weatherRepositories));
}

class MyApp extends StatelessWidget {
  WeatherRepositories weatherRepositories;
  MyApp({required this.weatherRepositories});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'WEATHER APP',
      home: Scaffold(
        body: SafeArea(
          child: WeatherApp(
            weatherRepositories: weatherRepositories,
          ),
        ),
      ),
    );
  }
}

class WeatherApp extends StatefulWidget {
  final WeatherRepositories weatherRepositories;
  WeatherApp({Key? key, required this.weatherRepositories}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeatherAppState();
  }
}

class WeatherAppState extends State<WeatherApp> {
  late WeatherRepositories _weatherRepositories;
  late Completer<void> _completer;
  final searchController = TextEditingController();
  String cityName = '';
  Position? position;
  double lat = 10.862860434146704, lng = 106.79033822453658;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _weatherRepositories = widget.weatherRepositories;
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return BlocProvider(
        create: (context) =>
            WeatherBloc(weatherRepositories: _weatherRepositories)
              ..add(WeatherEventRequest(lat: lat, lng: lng)),
        child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, weatherState) {
          if (weatherState is WeatherStateLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (weatherState is WeatherStateSuccess) {
            return Container(
              width: width,
              height: height,
              child: RefreshIndicator(
                onRefresh: () {
                  BlocProvider.of<WeatherBloc>(context)
                    ..add(WeatherEventRequest(lat: lat, lng: lng));
                  return _completer.future;
                },
                child: _buildWeatherUI(context, weatherState.weather),
              ),
            );
          } else {
            return Center(
              child: Text('Fail Loading'),
            );
          }
        }));
  }

  Future<void> _getAddress(double lat, double lng) async {
    GeoCode geoCode = GeoCode();
    var addresses =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lng);
    setState(() {
      cityName = addresses.city.toString();
    });
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position _position) async {
      setState(() {
        position = _position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  _changeKtoC(double K) {
    double C = K - 273.15;
    return C.roundToDouble();
  }

  _searchSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: searchController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Search City',
          hintStyle: TextStyle(color: Color(0xff7b7b7b)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
          ),
        ),
        onEditingComplete: () async {
          GeoCode geoCode = GeoCode();
          try {
            var coordinate =
                await geoCode.forwardGeocoding(address: searchController.text);
            if (coordinate.latitude != null && coordinate.longitude != null) {
              lat = coordinate.latitude!;
              lng = coordinate.longitude!;
              BlocProvider.of<WeatherBloc>(context)
                ..add(WeatherEventRequest(
                    lat: coordinate.latitude ?? 0.0,
                    lng: coordinate.longitude ?? 0.0));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.transparent,
              content: Text(
                "Please Check the city name again !",
                textAlign: TextAlign.center,
              ),
            ));
          }
        },
      ),
    );
  }

  _buildCurrentWeather(WeatherModel weather) {
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            cityName,
            style: TextStyle(fontSize: 35, color: Colors.white),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '${_changeKtoC(weather.current.temp)}℃',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        'Humidity : ${weather.current.humidity}%',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  Image.asset(
                    'images/icon_weather/${weather.current.weather[0].icon}.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Text(
                '${weather.current.weather[0].main}',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildWeatherUI(BuildContext context, WeatherModel weather) {
    _getAddress(weather.lat, weather.lon);
    return Container(
      color: Colors.blue.withOpacity(0.9),
      child: Column(
        children: [
          _searchSection(context),
          Expanded(
            child: ListView(
              children: [
                _buildCurrentWeather(weather),
                _buildWeatherDaily(context, weather)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Text(
              'Last updated on ${_formatTimeUtcToDateTime(weather.current.dt)}',
              style:
                  TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _buildWeatherDaily(BuildContext context, WeatherModel weather) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weather.daily.length,
        itemBuilder: (context, index) {
          return Container(
            height: 120,
            width: 160,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${_changeKtoC(weather.daily[index].temp.day)}℃',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${weather.daily[index].humidity}%',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                    Image.asset(
                      'images/icon_weather/${weather.daily[index].weather[0].icon}.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${_formatTimeUtcToDaily(weather.daily[index].dt)}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _formatTimeUtcToDateTime(int timeUtc) {
    print(timeUtc);
    final _time = DateTime.fromMillisecondsSinceEpoch(timeUtc * 1000);
    final DateFormat formatter = DateFormat('HH:mm dd/MM/yyyy');
    final String formatted = formatter.format(_time);
    print(formatted);
    return formatted;
  }

  _formatTimeUtcToDaily(int timeUtc) {
    print(timeUtc);
    final _time = DateTime.fromMillisecondsSinceEpoch(timeUtc * 1000);
    final DateFormat formatter = DateFormat('EEEE,MMM dd');
    final String formatted = formatter.format(_time);
    print(formatted);
    return formatted;
  }
}
