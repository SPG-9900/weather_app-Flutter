class Weather {
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final String description;
  final String icon;
  final double windSpeed;
  final int windDeg;
  final int clouds;
  final String cityName;
  final String country;

  Weather({
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.windDeg,
    required this.clouds,
    required this.cityName,
    required this.country,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDeg: json['wind']['deg'],
      clouds: json['clouds']['all'],
      cityName: json['name'],
      country: json['sys']['country'],
    );
  }
}

