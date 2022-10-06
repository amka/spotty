class CurrentWeather {
  final double temperature;
  final double windSpeed;
  final int weatherCode;

  CurrentWeather(
      {required this.temperature,
      required this.windSpeed,
      required this.weatherCode});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        weatherCode: json["weathercode"].toInt(),
        temperature: json["temperature"].toDouble(),
        windSpeed: json["windspeed"].toDouble(),
      );
}
