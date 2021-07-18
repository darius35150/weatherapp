import 'dart:io';

class SlashScreen {
  static void getSplashScreen() {
    // ignore: prefer_adjacent_string_concatenation
    stdout.writeln(
        '***************************************************************\n' +
            '***************************************************************\n' +
            '***************************************************************\n' +
            '*!!!!!!!!!!!!!!!!!Welcome to Weather App!!!!!!!!!!!!!!!!!!!!!!*\n' +
            '***************************************************************\n' +
            '***************************************************************\n' +
            '***************************************************************\n');
            
    stdout.writeln('Built using the following technologies: \n' +
        'Prog. Language:   Dart\n' +
        'Dev enviro:       VS Code\n' +
        'API:              Open Weather API\n\n');
    
    sleep(const Duration(seconds: 7));
  }
}
