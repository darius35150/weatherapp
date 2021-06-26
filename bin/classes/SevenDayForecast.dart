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
  String sevenDayEndURL = '&units=imperial&exclude=current,minutely,hourly,alerts&appid=';
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
    // print(geocodeResponse?.body.toString());
    geocodeConverter = JsonDecoder().convert(geocodeResponse!.body.toString());
    // print('geocodeLocation|  ${jsonConverter?.elementAt(0)['name']}  |');
    _lat = geocodeConverter?.elementAt(0)['lat'];
    _long = geocodeConverter?.elementAt(0)['lon'];

    await showSevenDayForecastData();
  }

  Future<void> showSevenDayForecastData() async {

    url = Uri.parse(sevenDayURL + latURL + _lat.toString() + longURL + _long.toString() + sevenDayEndURL + apiKey);

    sevenDayResponse = await http.post(url);
    sevenDayConverter = JsonDecoder().convert(sevenDayResponse!.body);
    // print(url);
    // print(DateTime.fromMillisecondsSinceEpoch(sevenDayConverter!['daily'][0]['dt'] * 1000));
    stdout.writeln(
        '| Day/Date                           | Weather               | Descr                    | Temp               | Feels Like        |');
    stdout.writeln(
        '------------------------------------------------------------------------------------------------------------');
    for(var data in sevenDayConverter!['daily'])
    {
      var datetime = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000).toString().substring(0,10);
      var day = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000).weekday;
      stdout.writeln('| ${getDayOfTheWeek(day)}  $datetime               | ${data['weather'][0]['main']}           ' +
          '     |' +
          ' ${data['weather'][0]['description']}' +
          '               |' +
          '  ${data['temp']['max']}' +
          '                |' +
          ' ${data['feels_like']['day']}' +
          '                |');
      stdout.writeln(
          '---------------------------------------------------------------------------------------------');
    }
  }

  String getDayOfTheWeek(int day)
  {
    switch(day)
    {
      case DateTime.monday:
        return 'Monday';
        break;
      case DateTime.tuesday:
        return 'Tuesday';
        break;
      case DateTime.wednesday:
        return 'Wednesday';
        break;
      case DateTime.thursday:
        return 'Thursday';
        break;
      case DateTime.friday:
        return 'Friday';
        break;
      case DateTime.saturday:
        return 'Saturday';
        break;
      case DateTime.sunday:
        return 'Sunday';
        break;
    }
    return '';
  }
}
