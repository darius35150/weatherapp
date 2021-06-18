import 'dart:io';
import 'package:intl/intl.dart';

class TimeScreen {
  var city, state;

  TimeScreen(var city, var state) {
    this.city = city;
    this.state = state;
  }
  
  static void showTime(city, state) {
    stdout.writeln('Current Weather In ${city.toString().toUpperCase()}, ${state.toString().toUpperCase()}');
    stdout.writeln('------------------------------------------');
    stdout.writeln(
        '|Current Date/Time:    ${DateFormat('MM-dd-yyyy - hh:mm').format(DateTime.now().toLocal())}|');
    stdout.writeln('------------------------------------------');
  }
}
