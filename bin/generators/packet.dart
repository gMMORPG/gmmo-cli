import 'dart:io';

import '../gdscript.dart';
import 'generator.dart';
import '../utils.dart';

class PacketGenerator implements IGenerator {
  @override
  final String outputDir = './client/core';

  @override
  void generate(String name, [List<String> attributes = const []]) {
    final className = Utils.toCamelCase(name);
    final packetName = name.toUpperCase();
    final packageDir = '$outputDir/$name';
    final filePath = '$packageDir/core.gd';

    Directory(packageDir).createSync(recursive: true);

    final variables = GDScript.generateVariables(attributes);
    final template = Utils.loadTemplate('packet');
    final content = template
        .replaceAll('\$className', className)
        .replaceAll('\$packetName', packetName)
        .replaceAll('\$variables', variables);

    File(filePath).writeAsStringSync(content);
    print('✅ Pacote "$className.gd" gerado em "$filePath"!');
  }
}
