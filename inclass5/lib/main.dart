import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';
  double _temperature = 0.0;
  String _weatherCondition = '';
  final List<Forecast> _forecastData = []; // List to store static forecast data

  void _fetchWeather() async {
    final cityName = _cityController.text;

    // Generate random temperature and weather condition
    final randomTemperature = Random().nextInt(16) + 15;
    final weatherConditions = ['Sunny', 'Cloudy', 'Rainy'];
    final randomWeatherCondition =
        weatherConditions[Random().nextInt(weatherConditions.length)];

    setState(() {
      _cityName = cityName;
      _temperature = randomTemperature.toDouble();
      _weatherCondition = randomWeatherCondition;
      _forecastData.clear(); // Clear previous forecast data
      _forecastData.addAll(
          _generateStaticForecast(cityName)); // Add static forecast data
    });
  }

  List<Forecast> _generateStaticForecast(String cityName) {
    // Replace with your desired static forecast data
    return [
      Forecast(day: 'Mon', temperature: 20, condition: 'Sunny'),
      Forecast(day: 'Tue', temperature: 22, condition: 'Cloudy'),
      Forecast(day: 'Wed', temperature: 25, condition: 'Rainy'),
      Forecast(day: 'Thu', temperature: 18, condition: 'Sunny'),
      Forecast(day: 'Fri', temperature: 21, condition: 'Cloudy'),
      Forecast(day: 'Sat', temperature: 23, condition: 'Sunny'),
      Forecast(day: 'Sun', temperature: 19, condition: 'Cloudy'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: 'Enter city name',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _fetchWeather,
                  child: const Text('Fetch Weather'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() => _forecastData.clear()),
                  child: const Text('Clear Forecast'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'City: $_cityName',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Temperature: $_temperature°C',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Weather Condition: $_weatherCondition',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              '7-Day Forecast',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: _forecastData.isEmpty
                  ? const Center(child: Text('No forecast data available'))
                  : ListView.builder(
                      itemCount: _forecastData.length,
                      itemBuilder: (context, index) {
                        final forecast = _forecastData[index];
                        return ListTile(
                          title: Text(forecast.day),
                          subtitle: Text(
                              '${forecast.temperature}°C - ${forecast.condition}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Forecast {
  final String day;
  final double temperature;
  final String condition;

  Forecast(
      {required this.day, required this.temperature, required this.condition});
}
