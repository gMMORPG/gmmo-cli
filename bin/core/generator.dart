import 'dart:io';
import '../gdscript.dart';
import '../utils.dart';

class PacketGenerator {
  final String outputDir;
  final bool isServer;

  PacketGenerator(this.isServer)
      : outputDir = isServer ? './server/core' : './client/core';

  void generate(String name, [List<String> attributes = const []]) {
    final prefix = isServer ? 'S' : 'C';
    final className = '$prefix${Utils.toCamelCase(name)}';
    final packetName = name.toUpperCase();
    final packageDir = '$outputDir/$name';
    final filePath = '$packageDir/core.gd';

    Directory(packageDir).createSync(recursive: true);

    final variables = GDScript.generateVariables(attributes);

    final parameters = attributes.map((attr) {
      final parts = attr.split(':');
      if (parts.length != 2) return '';
      final varName = parts[0];
      final type = GDScript.mapType(parts[1]);
      return '$varName: $type';
    }).join(', ');

    final handleSignature = isServer
        ? 'func handle($parameters, tree: SceneTree, peer_id: int) -> void'
        : 'func handle($parameters, tree: SceneTree) -> void';

    final assignments = attributes.map((attr) {
      final varName = attr.split(':')[0];
      return '\tself.$varName = $varName';
    }).join('\n');

    final multiplayerCall = isServer
        ? '\tMultiplayer.server.send_to(peer_id, header, [])'
        : '\tMultiplayer.client.send(header, [])';

    final template = '''
class_name $className extends RefCounted


var header = Packets.$packetName


$variables


$handleSignature:
$assignments

$multiplayerCall
''';

    File(filePath).writeAsStringSync(template);
    print('✅ Packet "$className.gd" generated at "$filePath"!');
  }
}
