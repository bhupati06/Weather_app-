import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../services/location_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/forecast_list.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDark;
  const HomeScreen({required this.toggleTheme, required this.isDark, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentLocationWeather(); // Screen load hote hi location se weather
  }

  void _loadCurrentLocationWeather() async {
    try {
      final position = await LocationService().getCurrentLocation();
      context.read<WeatherBloc>().add(
        FetchWeatherByLocation(position.latitude, position.longitude),
      );
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const LoadingIndicator();
            } else if (state is WeatherLoaded) {
              return SingleChildScrollView(   // 👈 overflow fix
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Search box
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter City Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              context
                                  .read<WeatherBloc>()
                                  .add(FetchWeather(_controller.text));
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Weather card
                    WeatherCard(weather: state.weather),
                    const SizedBox(height: 20),

                    // Forecast horizontal list with fixed height
                    SizedBox(
                      height: 160,
                      child: ForecastList(forecast: state.forecast),
                    ),
                  ],
                ),
              );
            } else if (state is WeatherError) {
              return Center(child: Text(state.message));
            } else {
              return Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter City Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            context
                                .read<WeatherBloc>()
                                .add(FetchWeather(_controller.text));
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Search weather by city name or wait for location...',
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
