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
  String longURL = '&long=';
  var url;
  List<dynamic> geocodeResponse = [];
  var sevenDayResponse;
  var apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';
  List? jsonConverter;

  double temp = 0;
  double feelsLike = 0;
  double _lat = 0;
  double _long = 0;

  int counter = 0;

  SevenDayForecast(this.city, this.state);

  Future<void> showSevenDayForecastData() async {
    url = Uri.parse(sevenDayURL + latURL + longURL + sevenDayEndURL + apiKey);
    sevenDayResponse = await http.post(url, body: {'name': 'doodle', 'color': 'green'});

    parseAndDisplayJson(sevenDayResponse.body);
  }

  Future<void> geocodeLocation() async {
    url = Uri.parse(
        geocodeURL + locationURL + city + ',' + state + geocodeEndURL + apiKey);
    response = await http.get(url);
    // geocodeResponse.add(response);
    print(response?.body.toString());
    jsonConverter = JsonDecoder().convert(response!.body.toString());
    print('geocodeLocation|  ${jsonConverter?.elementAt(0)['name']}  |');
  }

  void parseAndDisplayJson(var jsonFile) {
    // jsonConverter = JsonDecoder().convert(jsonFile);
    // print('parseAndDispalyJson:   | $jsonConverter|');
    // temp = ((jsonConverter?['main']['temp'] - 273.15) * 9) / 5 + 32;
    // feelsLike = ((jsonConverter?['main']['feels_like'] - 273.15) * 9) / 5 + 32;
    // List list = jsonConverter?['weather'];
    // // print(list.length);
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

  // ignore: unnecessary_getters_setters
  double get lat {
    return _lat;
  }

  // ignore: unnecessary_getters_setters
  double get long {
    return _long;
  }

  // ignore: unnecessary_getters_setters
  set lat(double lat) {
    _lat = lat;
  }

  // ignore: unnecessary_getters_setters
  set long(double long) {
    _long = long;
  }
}
