import 'dart:io';

// ignore: unused_import
import 'package:weatherapp/weatherapp.dart' as weatherapp;

import 'classes/CurrentWeatherData.dart';
// ignore: library_prefixes
import 'classes/OpeningScreen.dart' as openingScreen;
// ignore: library_prefixes
import 'classes/TimeScreen.dart' as timeScreen;
import 'classes/MainMenu.dart';
import 'classes/SevenDayForecast.dart';

String menuItem = '';
var city, state;
var currentWeatherData;
var sevenDayForecast;
var menu;

bool refreshIsRunning = false;

class WeatherApp {
  WeatherApp();

  void startApp() {
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

        refreshIsRunning = true;

        break;
      case '2':
        timeScreen.TimeScreen.showTime(city, state);

        sevenDayForecast = SevenDayForecast(city, state);
        sevenDayForecast.geocodeLocationAndDisplayData();

        refreshIsRunning = true;

        break;
      case '3':
        timeScreen.TimeScreen.showTime(city, state);

        break;
    }
  }

  void refresh() async {
    String? typeOfWeather = 'n';
    String? locations = 'n';
    stdout.write('Would you like to change weather type?(y/n)   ');
    typeOfWeather = stdin.readLineSync();
    if (typeOfWeather == 'n') {
      stdout.write('Would you like to change locations?(y/n)   ');
      locations = stdin.readLineSync();

      timeScreen.TimeScreen.showTime(city, state);
      currentWeatherData.showCurrentData();
    }
  }
}

Future<void> main(List<String> arguments) async {
  var app = WeatherApp();
  app.startApp();
}
