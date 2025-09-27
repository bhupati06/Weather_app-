import '../models/weather_model.dart';
import '../models/forecast_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final List<Forecast> forecast;

  WeatherLoaded(this.weather, this.forecast);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}