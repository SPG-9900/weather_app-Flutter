import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.currentWeather;

    if (weather == null) {
      return const SizedBox.shrink();
    }

    final temperature = weatherProvider.isCelsius
        ? weather.temperature
        : (weather.temperature * 9 / 5) + 32;
    final unit = weatherProvider.isCelsius ? '°C' : '°F';

    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${weather.cityName}, ${weather.country}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${temperature.toStringAsFixed(1)}$unit',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feels like: ${weather.feelsLike.toStringAsFixed(1)}$unit',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      'Min: ${weather.tempMin.toStringAsFixed(1)}$unit',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      'Max: ${weather.tempMax.toStringAsFixed(1)}$unit',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _WeatherInfoColumn(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '${weather.humidity}%',
                ),
                _WeatherInfoColumn(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '${weather.windSpeed} m/s',
                ),
                _WeatherInfoColumn(
                  icon: Icons.cloud,
                  label: 'Clouds',
                  value: '${weather.clouds}%',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherInfoColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherInfoColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: Colors.white70,
              ),
        ),
      ],
    );
  }
}
