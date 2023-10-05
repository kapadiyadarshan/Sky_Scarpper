import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/controllers/Weather_controller.dart';
import 'package:sky_scrapper/views/screens/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
