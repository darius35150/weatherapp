import 'dart:io';

class TimeScreen {
  var city, state;

  TimeScreen(var city, var state) {
    this.city = city;
    this.state = state;
  }
  static void showTime(city, state) {
    stdout.writeln('Current Weather In $city, $state');
    stdout.writeln('---------------------------------');
    stdout.writeln('Current Date:    ${DateTime.now()}');
  }
}
