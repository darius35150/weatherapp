import 'dart:io';

import 'package:weatherapp/weatherapp.dart' as weatherapp;
import 'package:http/http.dart' as http;

var url, response, city, state;
var apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';
String partialURL = 'https://api.openweathermap.org/data/2.5/weather?';
String locationURL = 'q=';
String keyURL = ',1&appid=';

Future<void> main(List<String> arguments) async {
  print('***************************************************************\n' +
      '***************************************************************\n' +
      '***************************************************************\n' +
      '*  Welcome to Weather App!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  *\n' +
      '***************************************************************\n' +
      '***************************************************************\n' +
      '***************************************************************\n');

  sleep(const Duration(seconds: 7));

  print('Please enter city:  ');
  city = stdin.readLineSync();

  print('Pleases enter state:  ');
  state = stdin.readLineSync();

  url = Uri.parse(
      partialURL + locationURL + city + ',' + state + keyURL + apiKey);

  print('Current Weather In $city, $state');
  print('---------------------------------');
  print(DateTime.now());

  response = await http.post(url, body: {'name': 'doodle', 'color': 'green'});

  print('Response Status:  ${response.statusCode}');
  print('Response body:   ${response.body}');
}
