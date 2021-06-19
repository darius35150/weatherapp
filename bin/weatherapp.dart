import 'dart:io';

// ignore: unused_import
import 'package:weatherapp/weatherapp.dart' as weatherapp;

import 'classes/CurrentWeatherData.dart';
// ignore: library_prefixes
import 'classes/OpeningScreen.dart' as openingScreen;
// ignore: library_prefixes
import 'classes/TimeScreen.dart' as timeScreen;
import 'classes/MainMenu.dart';
import 'classes/FiveDayForecast.dart';

String menuItem = '';
var city, state;
var currentWeatherData;
var fiveDayForecast;
var menu;

Future<void> main(List<String> arguments) async {
  openingScreen.SlashScreen.getSplashScreen();

  menu = MainMenu();
  menu.getMainMenu();

  stdout.write('\n\n');

  stdout.write('Please enter city:  ');
  city = stdin.readLineSync();

  stdout.write('Pleases enter state:  ');
  state = stdin.readLineSync();

  stdout.writeln('\n\n');

  switch (menu.menu_Item) {
    case '1':
      timeScreen.TimeScreen.showTime(city, state);

      currentWeatherData = CurrentWeatherData(city, state);
      currentWeatherData.showCurrentData();

      break;
    case '2':
      timeScreen.TimeScreen.showTime(city, state);

      fiveDayForecast = FiveDayForecast(city, state);
      fiveDayForecast.geocodeLocation();

      break;
    case '3':
      timeScreen.TimeScreen.showTime(city, state);

      break;
  }
}
