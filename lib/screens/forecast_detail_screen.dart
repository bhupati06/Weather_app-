import 'package:flutter/material.dart';
import '../models/forecast_model.dart';

class ForecastDetailScreen extends StatelessWidget {
  final Forecast forecast;

  const ForecastDetailScreen({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forecast Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(forecast.date, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('${forecast.temperature.toStringAsFixed(1)} °C',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(forecast.description, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}