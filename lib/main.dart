import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_appp/screens/onboarding_screen.dart';
import 'bloc/weather_bloc.dart';
import 'repository/weather_repository.dart';
import 'services/weather_service.dart';
import 'utils/theme.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(WeatherRepository(WeatherService())),
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: OnboardingScreen(
          toggleTheme: toggleTheme,
          isDark: isDarkMode,
        ),
      ),
    );
  }
}
