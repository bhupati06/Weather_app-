import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherService {
  final String apiKey = '543c7edce47867a4dd2a3275c1a7b9d5';

  // Current weather by city
  Future<Weather> getWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Current weather by location (lat/lon)
  Future<Weather> getWeatherByLocation(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // 5-day forecast (filtered: only 1 entry per day)
  Future<List<Forecast>> get5DayForecast(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> forecastList = data['list'];

      // Group by date -> keep only first record of each day
      Map<String, Forecast> dailyForecast = {};

      for (var item in forecastList) {
        final date = item['dt_txt'].split(" ")[0]; // yyyy-mm-dd
        if (!dailyForecast.containsKey(date)) {
          dailyForecast[date] = Forecast.fromJson(item);
        }
      }

      // Return only 5 days
      return dailyForecast.values.take(5).toList();
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
