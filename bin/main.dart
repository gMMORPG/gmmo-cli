import 'package:args/args.dart';
import 'dart:io';
import 'commands/help.dart';
import 'commands/welcome.dart';
import 'commands/generate_packet.dart';
import 'commands/list_packets.dart';
import 'commands/add_packet.dart';

void main(List<String> arguments) {
  runCLI(arguments);
}

void runCLI(List<String> arguments) {
  final parser = ArgParser()
    ..addCommand('help')
    ..addCommand(
      'generate',
      ArgParser()
        ..addCommand('client')
        ..addCommand('server'),
    )
    ..addCommand(
      'list',
      ArgParser()..addCommand('packets'),
    )
    ..addCommand(
      'add',
      ArgParser()..addCommand('packets'),
    );

  if (arguments.isEmpty) {
    showWelcome();
    exit(0);
  }

  try {
    final ArgResults argResults = parser.parse(arguments);

    if (argResults.command == null) {
      print('❌ Command not found. Use `gmmo --help` for help.');
      exit(1);
    }

    switch (argResults.command!.name) {
      case 'help':
        showHelp();
        break;

      case 'generate':
        generatePacket(argResults);
        break;

      case 'list':
        listPackets(argResults.command!);
        break;

      case 'add':
        addPacket(argResults.command!);
        break;

      default:
        print(
            '❌ Unknown command. Use `gmmo --help` to see available commands.');
        exit(1);
    }
  } catch (e) {
    print('❌ Error: Invalid command or arguments. Please check your input.');
    exit(1);
  }
}
