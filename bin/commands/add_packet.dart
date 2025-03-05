import 'package:args/args.dart';

import '../core/packets_list.dart';
import 'dart:io';

void addPacket(ArgResults addArgs) {
  final subCommand = addArgs.command?.name;

  if (subCommand == 'packets') {
    final args = addArgs.command?.rest ?? [];

    if (args.isEmpty) {
      print('❌ You must specify the packet name.');
      exit(1);
    }

    for (var element in args) {
      final packetName = element.toUpperCase();

      PacketManager(
        './shared/multiplayer/net/packets.gd',
      ).addPacket(packetName);
    }
  }
}
