import 'dart:io';

import 'classes/CurrentWeatherData.dart';
// ignore: library_prefixes
import 'classes/OpeningScreen.dart' as openingScreen;
// ignore: library_prefixes
import 'classes/TimeScreen.dart';
import 'classes/MainMenu.dart';
import 'classes/SevenDayForecast.dart';
import 'classes/FiveDayForecast.dart';
import 'classes/ClearScreen.dart';
import 'classes/WeatherTypes.dart';

String menuItem = '';
String sevenDay = 'SevenDayForecast';
String current = 'CurrentWeatherData';
String fiveDay = 'FiveDayForecast';

var city, state;
var currentWeatherData;
var sevenDayForecast;
var fiveDayForecast;
var menu;
var timeScreen;

bool refreshIsRunning = false;
var _apiKey = '9e00e7490b3e4fe0221f432d8767a854';

class WeatherApp {
  WeatherApp();

  void startApp(
      bool refreshing, String? changeLocation, String? changeWeatherType) {
    grabParameters(refreshing, changeLocation, changeWeatherType);

    showScreen();
  }

  void grabParameters(
      bool refreshing, String? changeLocation, String? changeWeatherType) {
    if (!refreshing) {
      openingScreen.SlashScreen.getSplashScreen();

      ClearScreen.clearAll();

      menu = MainMenu();
      menu.getMainMenu();

      stdout.write('\n\n');
      stdout.write('Please enter city:  ');
      city = stdin.readLineSync();

      stdout.write('Pleases enter state:  ');
      state = stdin.readLineSync();

      ClearScreen.clearAll();
    } else {
      if (changeWeatherType == 'y') {
        menu = MainMenu();
        menu.getMainMenu();

        ClearScreen.clearAll();
      }

      if (changeLocation == 'y') {
        stdout.write('Please enter city:  ');
        city = stdin.readLineSync();

        stdout.write('Pleases enter state:  ');
        state = stdin.readLineSync();

        ClearScreen.clearAll();
      }
    }
  }

  void showScreen() {
    switch (menu.menu_Item) {
      case '1':
        timeScreen = TimeScreen(city, state, WeatherTypes.WEATHER_TYPE_CURRENT);
        timeScreen.showTime();

        currentWeatherData = CurrentWeatherData(city, state);
        currentWeatherData.showCurrentData();

        refreshIsRunning = true;

        break;
      case '2':
        timeScreen = TimeScreen(city, state, WeatherTypes.WEATHER_TYPE_5DAY);
        timeScreen.showTime();

        fiveDayForecast = FiveDayForecast(city, state);
        fiveDayForecast.getFiveDayForecast();

        refreshIsRunning = true;

        break;
      case '3':
        timeScreen = TimeScreen(city, state, WeatherTypes.WEATHER_TYPE_7DAY);
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

    sleep(const Duration(minutes: 0));
    stdout.write('Would you like to change weather type?(y/n)   ');
    typeOfWeather = stdin.readLineSync();

    if (typeOfWeather == 'y') {
      stdout.write('Would you like to change locations?(y/n)   ');
      locations = stdin.readLineSync();
      var app = WeatherApp();
      app.startApp(refreshIsRunning, locations, typeOfWeather);
    } else if (typeOfWeather == 'n' && current == className) {
      stdout.write('Would you like to change locations?(y/n)   ');
      locations = stdin.readLineSync();

      if (locations == 'n') {
        timeScreen = TimeScreen(city, state, WeatherTypes.WEATHER_TYPE_CURRENT);
        timeScreen.showTime();
        currentWeatherData.showCurrentData();
      } else {
        var app = WeatherApp();
        app.startApp(refreshIsRunning, locations, typeOfWeather);
      }
    } else if (typeOfWeather == 'n' && sevenDay == className) {
      stdout.write('Would you like to change locations?(y/n)   ');
      locations = stdin.readLineSync();

      if (locations == 'n') {
        timeScreen = TimeScreen(city, state, WeatherTypes.WEATHER_TYPE_7DAY);
        timeScreen.showTime();
        sevenDayForecast.geocodeLocationAndDisplayData();
      } else {
        var app = WeatherApp();
        app.startApp(refreshIsRunning, locations, typeOfWeather);
      }
    } else {
      stdout.write('Would you like to change locations?(y/n)   ');
      locations = stdin.readLineSync();

      if (locations == 'n') {
        timeScreen = TimeScreen(city, state, WeatherTypes.WEATHER_TYPE_5DAY);
        timeScreen.showTime();
        fiveDayForecast.getFiveDayForecast();
      } else {
        var app = WeatherApp();
        app.startApp(refreshIsRunning, locations, typeOfWeather);
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
