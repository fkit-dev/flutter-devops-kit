import '../core/command.dart';

class HelpCommand extends Command {
  @override
  String get name => 'help';

  @override
  String get description => 'Show all available commands';

  @override
  Future<void> run(List<String> args) async {
    print('''
Flutter DevOps Kit

Available Commands:

help                    Show available commands
doctor                  Validate environment
init                    Initialize project
build apk <flavor>      Build APK
build aab <flavor>      Build AAB
firebase <flavor>       Upload APK to Firebase
feat <name>             Create feature module
''');
  }
}
