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

    for (var data in jsonConverter?['weather']) {
      stdout.writeln('|     Weather       |     Descr          |');
      stdout.writeln('------------------------------------------');
      stdout.writeln(
          '| ${data['main']}             | ${data['description']}          |');
      stdout.writeln('------------------------------------------\n\n');
    }
  }
}
