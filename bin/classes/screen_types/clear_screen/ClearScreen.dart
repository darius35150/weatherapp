import 'dart:io';


class ClearScreen{

  static void clearAll()
  {
    if (Platform.isWindows) {
      stdout.write(Process.runSync('cls', [], runInShell: true).stdout);
    } else if(Platform.isLinux){
      stdout.write(Process.runSync('clear', [], runInShell: true).stdout);
    }
  }
}