import 'dart:io';

class SlashScreen {
  static void getSplashScreen() {
    // ignore: prefer_adjacent_string_concatenation
    stdout.writeln(
        // ignore: prefer_adjacent_string_concatenation
        '***************************************************************\n' +
            '***************************************************************\n' +
            '***************************************************************\n' +
            '*!!!!!!!!!!!!!!!!!Welcome to Weather App!!!!!!!!!!!!!!!!!!!!!!*\n' +
            '***************************************************************\n' +
            '***************************************************************\n' +
            '***************************************************************\n');
            
    // ignore: prefer_adjacent_string_concatenation
    stdout.writeln('Built using the following technologies: \n' +
        'Prog. Language:   Dart\n' +
        'Dev enviro:       VS Code and Android Studio\n' +
        'API:              Open Weather API\n' +
        'Developer:        Darius Holley\n\n');
    
    sleep(const Duration(seconds: 7));
  }
}
