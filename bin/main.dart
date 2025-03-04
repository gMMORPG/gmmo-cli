import 'package:args/args.dart';
import 'generators/packet.dart';
import 'dart:io';
import 'commands/help.dart';

void main(List<String> arguments) {
  runCLI(arguments);
}

void runCLI(List<String> arguments) {
  final parser =
      ArgParser()
        ..addCommand('help')
        ..addCommand('generate', ArgParser()..addCommand('packet'));

  final argResults = parser.parse(arguments);

  if (argResults.command == null || argResults.command!.name == 'help') {
    showHelp();
    exit(0);
  }

  switch (argResults.command!.name) {
    case 'generate':
      final ArgResults generateArgs = argResults.command!;

      if (generateArgs.command?.name != 'packet') {
        print('❌ Uso correto: gmmo generate packet <nome_do_pacote>');

        exit(1);
      }

      final subCommand = generateArgs.command!.name;
      final args = generateArgs.command!.rest;

      if (args.isEmpty) {
        print('❌ Uso correto: gmmo generate $subCommand <nome>');
        exit(1);
      }

      final name = args[0];
      final attributes = args.skip(1).toList();

      switch (subCommand) {
        case 'packet':
          PacketGenerator().generate(name, attributes);
          break;
        default:
          print(
            '❌ Subcomando desconhecido. Use `gmmo --help` para ver os comandos.',
          );
          exit(1);
      }

      break;
    default:
      print('❌ Comando desconhecido. Use `gmmo --help` para ver os comandos.');
      exit(1);
  }
}
