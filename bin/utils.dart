class Utils {
  static String toCamelCase(String text) {
    return text.split('_').map((str) {
      return str[0].toUpperCase() + str.substring(1).toLowerCase();
    }).join('');
  }

  static String toUpperCase(String text) {
    return text.toUpperCase();
  }
}
