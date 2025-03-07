import 'dart:io';

void showWelcome() {
  print('''
🚀 Welcome to GMMO CLI!

Version: v0.0.3

🔗 GitHub: https://github.com/gMMORPG/gmmo-cli

For support or to contribute, visit our GitHub repository.

📝 Usage:
  gmmo generate <client|server> <packet_name> [attributes]    # Generate a packet
  gmmo list packets                                           # List all packets in the enum
  gmmo add packets <packet_name>                              # Add a new packet

❤️ Thank you for using GMMO CLI!

''');
  exit(0);
}
