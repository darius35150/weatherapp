import 'dart:io';
import 'package:intl/intl.dart';

class TimeScreen {
  var city, state, weatherType;

  TimeScreen(var city, var state, var weatherType) {
    this.city = city;
    this.state = state;
    this.weatherType = weatherType;
  }

  void showTime()
  {
    showOverloadTime(city, state, weatherType);
  }

  void showOverloadTime(var city, var state, var weatherType) {
    stdout.writeln(
        '$weatherType In ${city.toString().toUpperCase()}, ${state.toString().toUpperCase()}');
    stdout.writeln(
        '---------------------------------------------------------------------------------------------');
    stdout.writeln(
        '|Current Date/Time:    ${DateFormat('MM-dd-yyyy - hh:mm').format(DateTime.now().toLocal())}                                                   |');
    stdout.writeln(
        '---------------------------------------------------------------------------------------------');
  }
}
