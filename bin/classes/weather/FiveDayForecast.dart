import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../weatherapp.dart' as weather_app;
import '../weather_types/WeatherTypes.dart';

class FiveDayForecast {
  var city;
  var state;
  var url, response;
  var mainClass = weather_app.WeatherApp();

  String partialURL = 'https://api.openweathermap.org/data/2.5/forecast?';
  String locationURL = 'q=';
  String keyURL = ',1&units=imperial&appid=';

  double temp = 0;
  double feelsLike = 0;

  Map? fiveDayConverter;

  FiveDayForecast(this.city, this.state);

  Future<bool?> getFiveDayForecast() async {
    url = Uri.parse(partialURL +
        locationURL +
        city +
        ',' +
        state +
        ',' +
        keyURL +
        mainClass.apiKey);

    response = await http.post(url);

    fiveDayConverter = JsonDecoder().convert(response.body);

    stdout.writeln(
        '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    stdout.writeln(
        '| Day/Date                                         | Weather                              | Descr                           | Temp                    | Feels Like          |');
    stdout.writeln(
        '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------');

    for (var data in fiveDayConverter!['list']) {
      var datetime =
          DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000).toString().substring(0, 16);

      var day = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000).weekday;

      stdout.write('|');
      stdout.write(' ${getDayOfTheWeek(day)} $datetime');
      stdout.write('                             |');
      stdout.write(' ${data['weather'][0]['main'].toString().substring(0, 4)}');
      stdout.write('                                 |');
      stdout.write(
          ' ${data['weather'][0]['description'].toString().substring(0, data['weather'][0]['description'].toString().length)}');
      stdout.write(returnCorrectSpacing(
          data['weather'][0]['description'].toString().length));
      if (data['main']['temp'].toString().length < 5) {
        if (data['main']['temp'].toString().length == 2) {
          // ignore: prefer_adjacent_string_concatenation
          stdout.write(' ${data['main']['temp']}' + '.00');
        } else {
          // ignore: prefer_adjacent_string_concatenation
          stdout.write(' ${data['main']['temp']}' + '0');
        }
      } else {
        stdout.write(' ${data['main']['temp']}');
      }
      stdout.write('                   |');
      if (data['main']['feels_like'].toString().length < 5) {
        // ignore: prefer_adjacent_string_concatenation
        if (data['main']['feels_like'].toString().length == 2) {
          // ignore: prefer_adjacent_string_concatenation
          stdout.write(' ${data['main']['feels_like']}' + '.00');
        } else {
          // ignore: prefer_adjacent_string_concatenation
          stdout.write(' ${data['main']['feels_like']}' + '0');
        }
      } else {
        stdout.write(' ${data['main']['feels_like']}');
      }
      stdout.writeln('               |');
      stdout.writeln(
          '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    }

    weather_app.WeatherApp.refresh(WeatherTypes.WEATHER_CLASS_5DAY);
  }

  String getDayOfTheWeek(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
    }
    return '';
  }

  String? returnCorrectSpacing(int length) {
    switch (length) {
      case 5:
        return '                           |';
      case 6:
        return '                          |';
      case 7:
        return '                         |';
      case 8:
        return '                        |';
      case 9:
        return '                       |';
      case 10:
        return '                      |';
      case 11:
        return '                     |';
      case 12:
        return '                    |';
      case 13:
        return '                   |';
      case 14:
        return '                  |';
      case 15:
        return '                 |';
      case 16:
        return '                |';
      case 17:
        return '               |';
      case 18:
        return '              |';
      case 19:
        return '             |';
      case 20:
        return '            |';
    }
  }
}
