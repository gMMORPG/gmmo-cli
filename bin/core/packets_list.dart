import 'dart:io';

class PacketManager {
  final String filePath;

  PacketManager(this.filePath);

  List<String> loadPackets() {
    final file = File(filePath);

    if (!file.existsSync()) {
      print('❌ File "$filePath" not found!');
      exit(1);
    }

    final fileContent = file.readAsStringSync();
    final packetEnum = RegExp(r'\s*(\w+),\s*');
    final matches = packetEnum.allMatches(fileContent);

    return matches.map((match) => match.group(1)!).toList();
  }

  void addPacket(String packetName) {
    final currentPackets = loadPackets();

    if (currentPackets.contains(packetName)) {
      print('❌ Packet "$packetName" already exists.');
      exit(1);
    }

    final file = File(filePath);
    String fileContent = file.readAsStringSync();
    final lines = fileContent.split('\n');

    int enumStart = -1;
    int enumEnd = -1;
    int lastItemIndex = -1;
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].trim().startsWith('enum {')) {
        enumStart = i;
      }
      if (lines[i].trim() == '}' && enumStart != -1) {
        enumEnd = i;
        break;
      }

      if (enumStart != -1 && i > enumStart && i < lines.length - 1) {
        String trimmedLine = lines[i].trim();
        if (trimmedLine.isNotEmpty && !trimmedLine.startsWith('#')) {
          lastItemIndex = i;
        }
      }
    }

    if (enumStart == -1 || enumEnd == -1 || lastItemIndex == -1) {
      print('❌ Enum block not found or malformed in "$filePath".');
      exit(1);
    }

    String lastItemLine = lines[lastItemIndex];
    String lastItemTrimmed = lastItemLine.trim();

    if (!lastItemTrimmed.endsWith(',')) {
      String indentation = lastItemLine.substring(
        0,
        lastItemLine.indexOf(lastItemTrimmed),
      );

      lines[lastItemIndex] = '$indentation$lastItemTrimmed,';
    }

    String newPacketLine = '${lines[lastItemIndex].split(
      RegExp(r'\w'),
    )[0]}$packetName,';

    lines.insert(lastItemIndex + 1, newPacketLine);

    final newFileContent = lines.join('\n');
    file.writeAsStringSync(newFileContent);

    print('✅ Packet "$packetName" added successfully!');
  }

  void listPackets() {
    final packets = loadPackets();

    if (packets.isEmpty) {
      print('❌ No packets found in the file.');
    } else {
      print('Available packets:');
      for (var packet in packets) {
        print('- $packet');
      }
    }
  }
}
