import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequest extends WeatherEvent {
  final double lat, lng;
  const WeatherEventRequest({required this.lat, required this.lng});
  @override
  // TODO: implement props
  List<Object?> get props => [lat, lng];
}
