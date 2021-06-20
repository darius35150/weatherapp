import 'package:http/http.dart' as http;

class SevenDayForecast {
  var city;
  var state;
  String sevenDayURL = 'https://api.openweathermap.org/data/2.5/onecall?';
  String geocodeURL = 'http://api.openweathermap.org/geo/1.0/direct?';
  String locationURL = 'q=';
  String sevenDayEndURL = '&exlude=current,minutely,hourly,alerts&appid=';
  String geocodeEndURL = '&limit=1&appid=';

  var url, response;
  var apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';
  Map? jsonConverter;

  double temp = 0;
  double feelsLike = 0;

  SevenDayForecast(this.city, this.state);

  Future<void> showSevenDayForecastData() async {}

  Future<void> geocodeLocation() async {
    url = Uri.parse(geocodeURL + locationURL + city + ',' + state + geocodeEndURL + apiKey);

    print(url);
    response = await http.post(url, body: {'name': 'doodle', 'color': 'green'});

    print(response.body);
  }
}
