class Forecast {
  final String date;
  final double temperature;
  final String description;

  Forecast({
    required this.date,
    required this.temperature,
    required this.description,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: json['dt_txt'],
      temperature: (json['main']['temp']as num).toDouble(),
      description: json['weather'][0]['description'] ,
    );
  }
}