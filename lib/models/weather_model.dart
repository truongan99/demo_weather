import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  WeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.daily,
  });
  @override
  // TODO: implement props
  List<Object?> get props =>
      [lat, lon, timezone, timezoneOffset, current, daily];
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final Current current;
  final List<Daily> daily;

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
        lat: json["lat"] == null ? 0.0 : json["lat"].toDouble(),
        lon: json["lon"] == null ? 0.0 : json["lon"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromMap(json["current"]),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toMap(),
        "daily": List<dynamic>.from(daily.map((x) => x.toMap())),
      };
}

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
  });

  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final double pressure;
  final double humidity;
  final double dewPoint;
  final double uvi;
  final double clouds;
  final double visibility;
  final double windSpeed;
  final double windDeg;
  final double windGust;
  final List<Weather> weather;

  factory Current.fromMap(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"] == null ? 0.0 : json["temp"].toDouble(),
        feelsLike:
            json["feels_like"] == null ? 0.0 : json["feels_like"].toDouble(),
        pressure: json["pressure"] == null ? 0.0 : json["pressure"].toDouble(),
        humidity: json["humidity"] == null ? 0.0 : json["humidity"].toDouble(),
        dewPoint:
            json["dew_point"] == null ? 0.0 : json["dew_point"].toDouble(),
        uvi: json["uvi"] == null ? 0.0 : json["uvi"].toDouble(),
        clouds: json["clouds"] == null ? 0.0 : json["clouds"].toDouble(),
        visibility:
            json["visibility"] == null ? 0.0 : json["visibility"].toDouble(),
        windSpeed:
            json["wind_speed"] == null ? 0.0 : json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"] == null ? 0.0 : json["wind_deg"].toDouble(),
        windGust:
            json["wind_gust"] == null ? 0.0 : json["wind_gust"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
  });

  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final Temp temp;
  final FeelsLike feelsLike;
  final double pressure;
  final double humidity;
  final double dewPoint;
  final double windSpeed;
  final double windDeg;
  final double windGust;
  final List<Weather> weather;
  final double clouds;
  final double pop;
  final double rain;
  final double uvi;

  factory Daily.fromMap(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase:
            json["moon_phase"] == null ? 0.0 : json["moon_phase"].toDouble(),
        temp: Temp.fromMap(json["temp"]),
        feelsLike: FeelsLike.fromMap(json["feels_like"]),
        pressure: json["pressure"] == null ? 0.0 : json["pressure"].toDouble(),
        humidity: json["humidity"] == null ? 0.0 : json["humidity"].toDouble(),
        dewPoint:
            json["dew_point"] == null ? 0.0 : json["dew_point"].toDouble(),
        windSpeed:
            json["wind_speed"] == null ? 0.0 : json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"] == null ? 0.0 : json["wind_deg"].toDouble(),
        windGust:
            json["wind_gust"] == null ? 0.0 : json["wind_gust"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
        clouds: json["clouds"] == null ? 0.0 : json["clouds"].toDouble(),
        pop: json["pop"] == null ? 0.0 : json["pop"].toDouble(),
        rain: json["rain"] == null ? 0.0 : json["rain"].toDouble(),
        uvi: json["uvi"] == null ? 0.0 : json["uvi"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "temp": temp.toMap(),
        "feels_like": feelsLike.toMap(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
        "clouds": clouds,
        "pop": pop,
        "rain": rain == null ? null : rain,
        "uvi": uvi,
      };
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double day;
  final double night;
  final double eve;
  final double morn;

  factory FeelsLike.fromMap(Map<String, dynamic> json) => FeelsLike(
        day: json["day"] == null ? 0.0 : json["day"].toDouble(),
        night: json["night"] == null ? 0.0 : json["night"].toDouble(),
        eve: json["eve"].toDouble() == null ? 0.0 : json["eve"].toDouble(),
        morn: json["morn"].toDouble() == null ? 0.0 : json["morn"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  factory Temp.fromMap(Map<String, dynamic> json) => Temp(
        day: json["day"] == null ? 0.0 : json["day"].toDouble(),
        min: json["min"] == null ? 0.0 : json["min"].toDouble(),
        max: json["max"] == null ? 0.0 : json["max"].toDouble(),
        night: json["night"] == null ? 0.0 : json["night"].toDouble(),
        eve: json["eve"] == null ? 0.0 : json["night"].toDouble(),
        morn: json["morn"] == null ? 0.0 : json["morn"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}
