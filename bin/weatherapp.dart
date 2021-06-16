import 'dart:io';

import 'package:weatherapp/weatherapp.dart' as weatherapp;

import 'classes/CurrentWeatherData.dart';
// ignore: library_prefixes
import 'classes/OpeningScreen.dart' as openingScreen;
// ignore: library_prefixes
import 'classes/TimeScreen.dart' as timeScreen;

var url, response, city, state;
var apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';
String partialURL = 'https://api.openweathermap.org/data/2.5/weather?';
String locationURL = 'q=';
String keyURL = ',1&appid=';
var currentWeatherData;

Future<void> main(List<String> arguments) async {
  openingScreen.OpeningScreen.splashScreen();

  stdout.write('Please enter city:  ');
  city = stdin.readLineSync();

  stdout.write('Pleases enter state:  ');
  state = stdin.readLineSync();

  timeScreen.TimeScreen.showTime(city, state);

  currentWeatherData = CurrentWeatherData(city, state);
  currentWeatherData.showCurrentData();
}
