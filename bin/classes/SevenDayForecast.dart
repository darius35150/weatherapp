import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../weatherapp.dart' as mainclass;

class SevenDayForecast {
  var city;
  var state;
  http.Response? response;
  String sevenDayURL = 'https://api.openweathermap.org/data/2.5/onecall?';
  String geocodeURL = 'http://api.openweathermap.org/geo/1.0/direct?';
  String locationURL = 'q=';
  String sevenDayEndURL =
      '&units=imperial&exclude=current,minutely,hourly,alerts&appid=';
  String geocodeEndURL = ',1&limit=1&appid=';
  String latURL = 'lat=';
  String longURL = '&lon=';
  var url;
  http.Response? geocodeResponse;
  http.Response? sevenDayResponse;
  var apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';
  List? geocodeConverter;
  Map? sevenDayConverter;

  double temp = 0;
  double feelsLike = 0;
  double _lat = 0;
  double _long = 0;

  int counter = 0;

  SevenDayForecast(this.city, this.state);

  Future<void> geocodeLocationAndDisplayData() async {
    url = Uri.parse(
        geocodeURL + locationURL + city + ',' + state + geocodeEndURL + apiKey);
    geocodeResponse = await http.get(url);
  
    geocodeConverter = JsonDecoder().convert(geocodeResponse!.body.toString());
 
    _lat = geocodeConverter?.elementAt(0)['lat'];
    _long = geocodeConverter?.elementAt(0)['lon'];

    await showSevenDayForecastData();
  }

  Future<void> showSevenDayForecastData() async {
    url = Uri.parse(sevenDayURL +
        latURL +
        _lat.toString() +
        longURL +
        _long.toString() +
        sevenDayEndURL +
        apiKey);

    sevenDayResponse = await http.post(url);
    sevenDayConverter = JsonDecoder().convert(sevenDayResponse!.body);

    stdout.writeln(
        '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    stdout.writeln(
        '| Day/Date                                   | Weather                              | Descr                           | Temp                    | Feels Like          |');
    stdout.writeln(
        '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    for (var data in sevenDayConverter!['daily']) {
      var datetime = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000)
          .toString()
          .substring(0, 10);
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
      if (data['temp']['max'].toString().length < 5) {
        stdout.write(' ${data['temp']['max']}' + '0');
      } else {
        stdout.write(' ${data['temp']['max']}');
      }
      stdout.write('                   |');
      if (data['feels_like']['day'].toString().length < 5) {
        stdout.write(' ${data['feels_like']['day']}' + '0');
      } else {
        stdout.write(' ${data['feels_like']['day']}');
      }
      stdout.writeln('               |');
      stdout.writeln(
          '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    }

    mainclass.WeatherApp.refresh('SevenDayForecast');
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
        return '                    |';
      case 6:
        return '                    |';
      case 7:
        return '                    |';
      case 8:
        return '                    |';
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
        return '                |';
      case 16:
        return '                |';
      case 17:
        return '                  |';
      case 18:
        return '                  |';
      case 19:
        return '                  |';
      case 20:
        return '                  |';
    }
  }
}
