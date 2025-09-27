import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../utils/time_utils.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              weather.description.toLowerCase().contains('rain')
                  ? 'assets/rain.json'
                  : weather.description.toLowerCase().contains('clear')
                  ? 'assets/sunny.json'
                  : 'assets/cloudy.json',
              height: 120,
              width: 120,
            ),
            Text(
              weather.cityName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(weather.description,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Humidity: ${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('Wind: ${weather.windSpeed} m/s',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                    const SizedBox(height: 5),
                    Text('Sunrise',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(TimeUtils.formatTime(weather.sunrise),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.nights_stay_outlined, color: Colors.purple),
                    const SizedBox(height: 5),
                    Text('Sunset',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(TimeUtils.formatTime(weather.sunset),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}