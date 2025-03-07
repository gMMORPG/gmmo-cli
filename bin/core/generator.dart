import 'dart:io';
import 'package:path/path.dart' as p;
import '../gdscript.dart';
import '../utils.dart';

class PacketGenerator {
  final String outputDir;
  final bool isServer;

  PacketGenerator(this.isServer)
      : outputDir = isServer
            ? p.join('.', 'server', 'core')
            : p.join('.', 'client', 'core');

  void generate(String name, [List<String> attributes = const []]) {
    final prefix = isServer ? 'S' : 'C';
    final className = '$prefix${Utils.toCamelCase(name)}';
    final packetName = name.toUpperCase();
    final filePath = p.join(outputDir, '${name.toLowerCase()}.gd');

    Directory(outputDir).createSync(recursive: true);

    final parameters = attributes.isNotEmpty
        ? attributes.map((attr) {
            final parts = attr.split(':');
            if (parts.length != 2) return '';
            final varName = parts[0];
            final type = GDScript.mapType(parts[1]);
            return '$varName: $type';
          }).join(', ')
        : '';

    final handleSignature = isServer
        ? 'func handle(${parameters.isNotEmpty ? "$parameters, " : ""}tree: SceneTree, peer_id: int) -> void'
        : 'func handle(${parameters.isNotEmpty ? "$parameters, " : ""}tree: SceneTree) -> void';

    final multiplayerCall = isServer
        ? 'Multiplayer.server.send_to(peer_id, header, [])'
        : 'Multiplayer.client.send(header, [])';

    final template = '''
class_name $className extends RefCounted

var header = Packets.$packetName

$handleSignature:
\t$multiplayerCall
'''
        .trim();

    File(filePath).writeAsStringSync(template);
    print('✅ Packet "$className.gd" generated at "$filePath"!');
  }
}
