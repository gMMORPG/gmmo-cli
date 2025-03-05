import 'dart:io';
import 'package:args/args.dart';
import '../core/packets_list.dart';

void listPackets(ArgResults listArgs) {
  if (listArgs.command?.name == 'packets') {
    final packetManager = PacketManager(
      './shared/multiplayer/net/packets.gd',
    );
    packetManager.listPackets();
  } else {
    print('❌ You must specify the "packets" subcommand for listing.');
    exit(1);
  }
}
