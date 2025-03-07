class GDScript {
  static String mapSimpleType(String type) {
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
      case 'vector3':
        return 'Vector3';
      case 'vector2':
        return 'Vector2';
      default:
        return 'Variant';
    }
  }

  static String mapType(String type) {
    if (type.startsWith('array[')) {
      final innerType = type.substring(6, type.length - 1);
      return 'Array[${mapSimpleType(innerType)}]';
    }

    if (type.startsWith('dictionary[')) {
      final types =
          type.substring(10, type.length - 1).split(RegExp(r'[\s-]+'));
      if (types.length == 2) {
        return 'Dictionary[${mapSimpleType(types[0].trim())}, ${mapSimpleType(types[1].trim())}]';
      }
      return 'Dictionary';
    }

    return mapSimpleType(type);
  }

  static String generateVariables(List<String> attributes) {
    return attributes.map((attr) {
      final parts = attr.split(':');
      if (parts.length != 2) {
        return '';
      }

      final varName = parts[0];
      final type = mapType(parts[1]);
      final defaultValue = getDefaultValueForType(type);

      return 'var $varName: $type = $defaultValue';
    }).join('\n');
  }

  static String getDefaultValueForType(String type) {
    if (type.startsWith('Array[')) {
      return '[]';
    }

    switch (type) {
      case 'int':
        return '-1';
      case 'String':
        return '""';
      case 'float':
        return '0.0';
      case 'bool':
        return 'false';
      case 'Array':
        return '[]';
      case 'Dictionary':
        return '{}';
      case 'Vector3':
        return 'Vector3.ZERO';
      case 'Vector2':
        return 'Vector2.ZERO';
      default:
        return 'null';
    }
  }
}
