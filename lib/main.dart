import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import "package:intl/intl.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String selectedCity = 'Toshkent';
  double opacity = 0;

  final Map<String, Map<String, String>> weatherData = {
    'Toshkent': {
      'temperature': '28°C',
      'status': 'Quyoshli',
      'image': 'assets/tashkent.png',
    },
    'Samarqand': {
      'temperature': '25°C',
      'status': 'Bulutli',
      'image': 'assets/sam.png',
    },
    'Buxoro': {
      'temperature': '32°C',
      'status': 'Issiq',
      'image': 'assets/bukhara.png',
    },
  };

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWeather = weatherData[selectedCity]!;

    // Sana va vaqt
    String currentTime = DateFormat('HH:mm').format(DateTime.now());
    String currentDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());

    // Fon rangi
    Color backgroundColor = Colors.blue.shade100;
    if (currentWeather['status'] == 'Bulutli') {
      backgroundColor = Colors.grey.shade300;
    } else if (currentWeather['status'] == 'Issiq') {
      backgroundColor = Colors.orange.shade100;
    }

    // Icon tanlash
    IconData icon = Icons.wb_sunny;
    if (currentWeather['status'] == 'Bulutli') {
      icon = Icons.cloud;
    } else if (currentWeather['status'] == 'Issiq') {
      icon = Icons.wb_incandescent;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Offline Ob-havo'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedCity,
              items: weatherData.keys.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newCity) {
                setState(() {
                  selectedCity = newCity!;
                  opacity = 0;
                });
                Future.delayed(Duration(milliseconds: 300), () {
                  setState(() {
                    opacity = 1;
                  });
                });
              },
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background rasm
                    Image.asset(
                      currentWeather['image']!,
                      fit: BoxFit.cover,
                    ),
                    // Qorong'u filter (shaffof qoplama)
                    Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    // Matn va icon
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: opacity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            currentWeather['status']!,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            currentWeather['temperature']!,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Sana: $currentDate', style: TextStyle(fontSize: 16)),
            Text('Vaqt: $currentTime', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
