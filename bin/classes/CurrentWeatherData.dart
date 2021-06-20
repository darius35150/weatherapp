import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class CurrentWeatherData {
  var city;
  var state;
  String partialURL = 'https://api.openweathermap.org/data/2.5/weather?';
  String locationURL = 'q=';
  String keyURL = ',1&appid=';

  var url, response;
  var apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';
  Map? jsonConverter;

  double temp = 0;
  double feelsLike = 0;

  int counter = 0;

  CurrentWeatherData(var city, var state) {
    this.city = city;
    this.state = state;
  }

  Future<void> showCurrentData() async {
    url = Uri.parse(
        partialURL + locationURL + city + ',' + state + keyURL + apiKey);

    response = await http.post(url, body: {'name': 'doodle', 'color': 'green'});

    // print('Response Status:  ${response.statusCode}');
    // print('Response body:   ${response.body}');

    parseAndDisplayJson(response.body);
  }

  void parseAndDisplayJson(var jsonFile) {
    jsonConverter = JsonDecoder().convert(jsonFile);

    temp = ((jsonConverter?['main']['temp'] - 273.15) * 9) / 5 + 32;
    feelsLike = ((jsonConverter?['main']['feels_like'] - 273.15) * 9) / 5 + 32;
    List list = jsonConverter?['weather'];
    // print(list.length);
    for (var data in jsonConverter?['weather']) {
      counter += 1;
      if (counter != list.length) {
        stdout.writeln(
            '| Weather               | Descr                    | Temp               | Feels Like        |');
      }
      stdout.writeln(
          '---------------------------------------------------------------------------------------------');
      stdout.writeln('| ${data['main']}           ' +
          '     |' +
          ' ${data['description']}' +
          '          |' +
          ' ${temp.round()}' +
          '                 |' +
          ' ${feelsLike.round()}' +
          '                |');
      if (list.length > 1) {
        stdout.writeln(
            '---------------------------------------------------------------------------------------------');
      }
      else{
        stdout.writeln(
            '---------------------------------------------------------------------------------------------\n\n');
      }
    }
  }
}
