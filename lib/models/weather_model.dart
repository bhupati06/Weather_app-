class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.description,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.temperature,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? "Unknown",
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      temperature: (json['main']['temp'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }


  Weather copyWith({
    String? cityName,
    double? temperature,
    String? description,
    int? humidity,
    double? windSpeed,
    int? sunrise,
    int? sunset,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      temperature: temperature ?? this.temperature,
      description: description ?? this.description,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }
}
