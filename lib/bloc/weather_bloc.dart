import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        final forecast = await weatherRepository.fetchForecast(event.cityName);
        emit(WeatherLoaded(weather, forecast));
      } catch (e) {
        emit(WeatherError("Failed to load weather data"));
      }
    });


    on<FetchWeatherByLocation>((event, emit) async {
      emit(WeatherLoading());
      try {
        final data = await weatherRepository.fetchWeatherByLocation(
          event.lat,
          event.lon,
        );
        emit(WeatherLoaded(
          data["weather"],
          data["forecast"],
        ));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}