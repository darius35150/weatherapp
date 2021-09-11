import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../weatherapp.dart' as app;
import 'WeatherTypes.dart';

class CurrentWeatherData {
  var city;
  var state;
  String partialURL = 'https://api.openweathermap.org/data/2.5/weather?';
  String locationURL = 'q=';
  String keyURL = ',1&appid=';

  var url, response;
  var mainClass;

  Map? jsonConverter;

  double temp = 0;
  double feelsLike = 0;

  int counter = 0;

  CurrentWeatherData(var city, var state) {
    this.city = city;
    this.state = state;
  }

  Future<bool?> showCurrentData() async {
    mainClass = app.WeatherApp();
    url = Uri.parse(partialURL +
        locationURL +
        city +
        ',' +
        state +
        keyURL +
        mainClass.apiKey);

    // stdout.write(url);
    response = await http.post(url, body: {'name': 'doodle', 'color': 'green'});

    parseAndDisplayJson(response.body);

    app.WeatherApp.refresh(WeatherTypes.WEATHER_CLASS_CURRENT);
  }

  void parseAndDisplayJson(var jsonFile) {
    jsonConverter = JsonDecoder().convert(jsonFile);

    temp = ((jsonConverter?['main']['temp'] - 273.15) * 9) / 5 + 32;
    feelsLike = ((jsonConverter?['main']['feels_like'] - 273.15) * 9) / 5 + 32;
    List list = jsonConverter?['weather'];

    for (var data in jsonConverter?['weather']) {
      if (counter != list.length) {
        stdout.writeln(
            '| Weather               | Descr                    | Temp               | Feels Like        |');
      }
      stdout.writeln(
          '---------------------------------------------------------------------------------------------');
      stdout.write('| ${data['main']}');
      stdout.write(returnCorrectSpacingForWeatherColumn(data['main'].toString().length));

      if (data['description'].toString().length > 13) {
        stdout.write(' ${data['description'].toString()}');
      } else {
        stdout.write(' ${data['description'].toString()}');
      }

      stdout.write(returnCorrectSpacingForDescrColumn(data['description'].toString().length));
      stdout.write('  ${temp.round()}');
      stdout.write('                |');
      stdout.write(' ${feelsLike.round()}');
      stdout.writeln('                |');
      if (list.length > 1) {
        stdout.writeln(
            '---------------------------------------------------------------------------------------------');
      } else {
        stdout.writeln(
            '---------------------------------------------------------------------------------------------\n\n');
      }
      counter += 1;
    }
  }

  String? returnCorrectSpacingForDescrColumn(int length) {
    switch (length) {
      case 5:
        return '                     |';
      case 6:
        return '                    |';
      case 7:
        return '                   |';
      case 8:
        return '                  |';
      case 9:
        return '                |';
      case 10:
        return '               |';
      case 11:
        return '              |';
      case 12:
        return '             |';
      case 13:
        return '            |';
      case 14:
        return '           |';
      case 15:
        return '          |';
      case 16:
        return '         |';
      case 17:
        return '        |';
      case 18:
        return '       |';
      case 19:
        return '      |';
      case 20:
        return '     |';
    }
  }

  String? returnCorrectSpacingForWeatherColumn(int length) {
    switch (length) {
      case 4:
        return '                  |';
      case 5:
        return '                 |';
      case 6:
        return '                |';
      case 7:
        return '               |';
      case 8:
        return '              |';
      case 9:
        return '             |';
      case 10:
        return '            |';
      case 11:
        return '           |';
      case 12:
        return '          |';
      case 13:
        return '         |';
      case 14:
        return '        |';
      case 15:
        return '       |';
      case 16:
        return '      |';
      case 17:
        return '     |';
      case 18:
        return '    |';
      case 19:
        return '   |';
      case 20:
        return '  |';
    }
  }
}
