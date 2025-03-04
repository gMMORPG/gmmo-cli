class GDScript {
  static String mapType(String type) {
    if (type.startsWith('array[')) {
      final innerType = type.substring(6, type.length - 1);
      return 'Array[${innerType[0].toUpperCase()}${innerType.substring(1)}]';
    }

    switch (type.toLowerCase()) {
      case 'int':
        return 'int';
      case 'string':
        return 'String';
      case 'float':
        return 'float';
      case 'bool':
        return 'bool';
      case 'array':
        return 'Array';
      case 'dictionary':
        return 'Dictionary';
      default:
        return 'Variant';
    }
  }

  static String generateVariables(List<String> attributes) {
    return attributes
        .map((attr) {
          final parts = attr.split(':');
          if (parts.length != 2) {
            return '';
          }

          final varName = parts[0];
          final type = mapType(parts[1]);

          if (type.startsWith('Array')) {
            return 'var $varName: $type = []';
          }

          if (type.startsWith('Dictionary')) {
            return 'var $varName: $type = {}';
          }

          final defaultValue = defaultValueForType(type);
          return 'var $varName: $type = $defaultValue';
        })
        .join('\n');
  }

  static String defaultValueForType(String type) {
    switch (type) {
      case 'int':
        return '-1';
      case 'String':
        return '""';
      case 'float':
        return '0.0';
      case 'bool':
        return 'false';
      default:
        return 'null';
    }
  }
}
