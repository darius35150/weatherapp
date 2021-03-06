import 'dart:io';

class MainMenu {
  String? _menuItem = '';

  MainMenu();

  void getMainMenu() {
    stdout.writeln('-----------------------------------------------');
    stdout.writeln('| Please select from the menu below           |');
    stdout.writeln('-----------------------------------------------');
    stdout.writeln('| Current Weather |     5 Day |     7 Day     |');
    stdout.writeln('-----------------------------------------------');
    stdout.writeln('| Enter 1         | Enter 2   |  Enter 3      |');
    stdout.writeln('-----------------------------------------------');

    stdout.write('Please enter forecast type:   ');
    _menuItem = stdin.readLineSync();
  }

  String? get menu_Item{
    return _menuItem;
  }
}
