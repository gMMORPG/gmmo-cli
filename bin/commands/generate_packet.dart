import 'dart:io';
import 'package:args/args.dart';
import '../core/generator.dart';

void generatePacket(ArgResults argResults) {
  final ArgResults generateArgs = argResults.command!;
  final subCommand = generateArgs.command?.name;
  final args = generateArgs.command?.rest ?? [];

  if (subCommand == null ||
      (subCommand != 'client' && subCommand != 'server')) {
    print(
      '❌ Correct usage: gmmo generate <client|server> <packet_name> [attributes]',
    );
    exit(1);
  }

  if (args.isEmpty) {
    print('❌ You must specify the packet name.');
    exit(1);
  }

  final name = args[0];
  final attributes = args.skip(1).toList();
  final bool isserver = subCommand == 'server';

  PacketGenerator(isserver).generate(name, attributes);
}
