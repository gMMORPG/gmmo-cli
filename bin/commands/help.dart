import 'dart:io';

void showHelp() {
  print('''
🚀 GMMO CLI Help:

Commands:
  generate <client|server> <packet_name> [attributes]   # Generate a packet
  list packets                                          # List all packets in the enum
  add packets <packet_name>                             # Add a new packet

Examples:
  gmmo generate client player id:int name:string
  gmmo generate server enemy id:int health:float array:float
  
  gmmo add packets ONE
  gmmo add packets ONE TWO THREE

''');
  exit(0);
}
