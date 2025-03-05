import 'dart:io';

import '../gdscript.dart';
import '../utils.dart';

class PacketGenerator {
  final String outputDir;
  final bool isServer;

  PacketGenerator(this.isServer)
      : outputDir = isServer ? './server/core' : './client/core';

  void generate(String name, [List<String> attributes = const []]) {
    final className = Utils.toCamelCase(name);
    final packetName = name.toUpperCase();
    final packageDir = '$outputDir/$name';
    final filePath = '$packageDir/core.gd';

    Directory(packageDir).createSync(recursive: true);

    final variables = GDScript.generateVariables(attributes);

    final template = '''
class_name $className extends Packet
${variables.isNotEmpty ? '\n\n$variables\n' : ''}

func _init():
    header = Packets.$packetName


func serialize(writer: StreamPeerBuffer) -> void:
    super.serialize(writer)


func deserialize(reader: StreamPeerBuffer) -> void:
    super.deserialize(reader)


func handle(_tree: SceneTree, id: int = -1) -> void:
    pass
''';

    File(filePath).writeAsStringSync(template);
    print('✅ Packet "$className.gd" generated at "$filePath"!');
  }
}
