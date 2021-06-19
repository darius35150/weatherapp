import 'package:http/http.dart' as http;

class FiveDayForecast {
  var city;
  var state;
  String geocodeURL = 'https://api.openweathermap.org/data/2.5/forecast?';
  String locationURL = 'q=';
  String keyURL = ',1&appid=';

  var url, response;
  var apiKey = '40d60d805e0cad1cd92cf0bcf8f3aece';
  Map? jsonConverter;

  double temp = 0;
  double feelsLike = 0;

  FiveDayForecast(this.city, this.state);

  Future<void> showSevenDayForecastData() async {}

  Future<void> geocodeLocation() async {
    url = Uri.parse(geocodeURL + locationURL + city + ',' + state + keyURL + apiKey);

    print(url);
    response = await http.post(url, body: {'name': 'doodle', 'color': 'green'});

    print(response.body);
  }
}
