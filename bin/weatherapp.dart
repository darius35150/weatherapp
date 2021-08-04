import 'dart:io';

import 'classes/CurrentWeatherData.dart';
// ignore: library_prefixes
import 'classes/OpeningScreen.dart' as openingScreen;
// ignore: library_prefixes
import 'classes/TimeScreen.dart';
import 'classes/MainMenu.dart';
import 'classes/SevenDayForecast.dart';
import 'classes/FiveDayForecast.dart';

String menuItem = '';
String sevenDay = 'SevenDayForecast';
String current = 'CurrentWeatherData';

var city, state;
var currentWeatherData;
var sevenDayForecast;
var fiveDayForecast;
var menu;
var timeScreen;

var WEATHER_TYPE_CURRENT = 'Current Weather Forecast';
var WEATHER_TYPE_5DAY = '5 Day Weather Forecast';
var WEATHER_TYPE_7DAY = '7 Day Weather Forecast';

bool refreshIsRunning = false;
var _apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';

class WeatherApp {
  WeatherApp();

  void startApp(
      bool refreshing, String? changeLocation, String? changeWeatherType) {
    if (!refreshing) {
      openingScreen.SlashScreen.getSplashScreen();

      menu = MainMenu();
      menu.getMainMenu();

      stdout.write('\n\n');
      stdout.write('Please enter city:  ');
      city = stdin.readLineSync();

      stdout.write('Pleases enter state:  ');
      state = stdin.readLineSync();

      stdout.writeln('\n\n');
    } else {
      if (changeWeatherType == 'y') {
        menu = MainMenu();
        menu.getMainMenu();

        stdout.write('\n\n');
      }

      if (changeLocation == 'y') {
        stdout.write('Please enter city:  ');
        city = stdin.readLineSync();

        stdout.write('Pleases enter state:  ');
        state = stdin.readLineSync();

        stdout.writeln('\n\n');
      }
    }

    if (Platform.isWindows) {
      stdout.write(Process.runSync('cls', [], runInShell: true).stdout);
    } else {
      stdout.write(Process.runSync('clear', [], runInShell: true).stdout);
    }

    switch (menu.menu_Item) {
      case '1':
        timeScreen = TimeScreen(city, state, WEATHER_TYPE_CURRENT);
        timeScreen.showTime();

        currentWeatherData = CurrentWeatherData(city, state);
        currentWeatherData.showCurrentData();

        refreshIsRunning = true;

        break;
      case '2':
        timeScreen = TimeScreen(city, state, WEATHER_TYPE_5DAY);
        timeScreen.showTime();

        fiveDayForecast = FiveDayForecast(city, state);
        fiveDayForecast.getFiveDayForecast();

        refreshIsRunning = true;
        
        break;
      case '3':
        timeScreen = TimeScreen(city, state, WEATHER_TYPE_7DAY);
        timeScreen.showTime();

        sevenDayForecast = SevenDayForecast(city, state);
        sevenDayForecast.geocodeLocationAndDisplayData();

        refreshIsRunning = true;

        break;
    }
  }

  static void refresh(var className) async {
    String? typeOfWeather = 'n';
    String? locations = 'n';

    sleep(const Duration(minutes: 5));
    stdout.write('Would you like to change weather type?(y/n)   ');
    typeOfWeather = stdin.readLineSync();
    if (typeOfWeather == 'n' && current == className) {
      stdout.write('Would you like to change locations?(y/n)   ');
      locations = stdin.readLineSync();

      if (locations == 'n') {
        timeScreen.TimeScreen.showTime(city, state);
        currentWeatherData.showCurrentData();
      } else {
        var app = WeatherApp();
        app.startApp(refreshIsRunning, locations, typeOfWeather);
      }
    } else {
      if (typeOfWeather == 'n' && sevenDay == className) {
        stdout.write('Would you like to change locations?(y/n)   ');
        locations = stdin.readLineSync();

        if (locations == 'n') {
          timeScreen.TimeScreen.showTime(city, state);
          currentWeatherData.showCurrentData();
        } else {
          var app = WeatherApp();
          app.startApp(refreshIsRunning, locations, typeOfWeather);
        }
      }
    }

    if (typeOfWeather == 'y' && current == className) {
      stdout.write('Would you like to change locations?(y/n)   ');
      locations = stdin.readLineSync();
      if (locations == 'y') {
        var app = WeatherApp();
        app.startApp(refreshIsRunning, locations, typeOfWeather);
      } else {
        var app = WeatherApp();
        app.startApp(refreshIsRunning, locations, typeOfWeather);
      }
    } else {
      if (typeOfWeather == 'y' && sevenDay == className) {
        stdout.write('Would you like to change locations?(y/n)   ');
        locations = stdin.readLineSync();

        if (locations == 'y') {
          var app = WeatherApp();
          app.startApp(refreshIsRunning, locations, typeOfWeather);
        } else {
          var app = WeatherApp();
          app.startApp(refreshIsRunning, locations, typeOfWeather);
        }
      }
    }
  }

  String get apiKey {
    return _apiKey;
  }
}

Future<void> main(List<String> arguments) async {
  var app = WeatherApp();
  app.startApp(refreshIsRunning, 'n', null);
}
