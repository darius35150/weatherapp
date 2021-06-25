import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class SevenDayForecast {

  var city;
  var state;
  http.Response? response;
  String sevenDayURL = 'https://api.openweathermap.org/data/2.5/onecall?';
  String geocodeURL = 'http://api.openweathermap.org/geo/1.0/direct?';
  String locationURL = 'q=';
  String sevenDayEndURL = '&exlude=current,minutely,hourly,alerts&appid=';
  String geocodeEndURL = ',1&limit=1&appid=';
  String latURL = 'lat=';
  String longURL = '&lon=';
  var url;
  http.Response? geocodeResponse;
  http.Response? sevenDayResponse;
  var apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';
  List? jsonConverter;

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
    // print(geocodeResponse?.body.toString());
    jsonConverter = JsonDecoder().convert(geocodeResponse!.body.toString());
    // print('geocodeLocation|  ${jsonConverter?.elementAt(0)['name']}  |');
    _lat = jsonConverter?.elementAt(0)['lat'];
    _long = jsonConverter?.elementAt(0)['lon'];

    await showSevenDayForecastData();
  }

  Future<void> showSevenDayForecastData() async {

    url = Uri.parse(sevenDayURL + latURL + _lat.toString() + longURL + _long.toString() + sevenDayEndURL + apiKey);

    sevenDayResponse = await http.post(url, body: {'name': 'doodle', 'color': 'green'});

    print(sevenDayResponse!.body);
    // for(var data in sevenDayResponse)
    // for (var data in jsonConverter?['weather']) {
    //   if (counter != list.length) {
    //     stdout.writeln(
    //         '| Weather               | Descr                    | Temp               | Feels Like        |');
    //   }
    //   stdout.writeln(
    //       '---------------------------------------------------------------------------------------------');
    //   stdout.writeln('| ${data['main']}           ' +
    //       '     |' +
    //       ' ${data['description']}' +
    //       '               |' +
    //       '  ${temp.round()}' +
    //       '                |' +
    //       ' ${feelsLike.round()}' +
    //       '                |');
    //   if (list.length > 1) {
    //     stdout.writeln(
    //         '---------------------------------------------------------------------------------------------');
    //   } else {
    //     stdout.writeln(
    //         '---------------------------------------------------------------------------------------------\n\n');
    //   }
    //   counter += 1;
    // }
  }
}
