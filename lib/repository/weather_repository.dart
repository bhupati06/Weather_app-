import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';

class WeatherRepository {
  final WeatherService weatherService;

  WeatherRepository(this.weatherService);

  /// Fetch weather by city name
  Future<Weather> fetchWeather(String cityName) async {
    return await weatherService.getWeather(cityName);
  }

  /// Fetch 5-day forecast by city name
  Future<List<Forecast>> fetchForecast(String cityName) async {
    final forecasts = await weatherService.get5DayForecast(cityName);
    return _filterDailyForecast(forecasts);
  }

  /// Fetch weather and forecast by user location (lat/lon)
  Future<Map<String, dynamic>> fetchWeatherByLocation(
      double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=543c7edce47867a4dd2a3275c1a7b9d5&units=metric"),
    );

    final forecastResponse = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=543c7edce47867a4dd2a3275c1a7b9d5&units=metric"),
    );

    if (response.statusCode == 200 && forecastResponse.statusCode == 200) {
      final rawForecasts =
      (jsonDecode(forecastResponse.body)['list'] as List)
          .map((item) => Forecast.fromJson(item))
          .toList();

      // Filter daily forecasts (only 12:00:00)
      final filteredForecasts = _filterDailyForecast(rawForecasts);

      return {
        "weather": Weather.fromJson(jsonDecode(response.body)),
        "forecast": filteredForecasts,
      };
    } else {
      throw Exception("Failed to fetch weather");
    }
  }

  /// 🔥 Helper function - filter only one forecast per day (12:00 PM)
  List<Forecast> _filterDailyForecast(List<Forecast> forecasts) {
    final Map<String, Forecast> dailyForecasts = {};

    for (var item in forecasts) {
      final date = item.date.split(" ")[0]; // e.g. "2025-09-14"
      if (!dailyForecasts.containsKey(date) &&
          item.date.contains("12:00:00")) {
        dailyForecasts[date] = item;
      }
    }

    return dailyForecasts.values.toList();
  }
}