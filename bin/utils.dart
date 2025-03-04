import 'dart:io';

class Utils {
  static toCamelCase(String text) {
    return text
        .split('_')
        .map((str) {
          return str[0].toUpperCase() + str.substring(1).toLowerCase();
        })
        .join('');
  }

  static String toUpperCase(String text) {
    return text.toUpperCase();
  }

  static loadTemplate(String type) {
    final templatePath = 'templates/$type.txt';
    if (!File(templatePath).existsSync()) {
      print('❌ Template "$type.txt" não encontrado!');
      exit(1);
    }
    return File(templatePath).readAsStringSync();
  }
}
