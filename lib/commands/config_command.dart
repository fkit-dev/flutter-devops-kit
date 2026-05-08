import '../core/command.dart';
import '../services/config_service.dart';

class ConfigCommand extends Command {
  @override
  String get name => 'config';

  @override
  String get description => 'Print loaded config';

  @override
  Future<void> run(List<String> args) async {
    final config = await ConfigService.load();

    print('\n📦 Loaded Project Config\n');

    print('Use FVM: ${config.useFvm}');
    print('Main Entry: ${config.mainEntry}');
    print('Default Flavor: ${config.defaultFlavor}');
    print('Tester Group: ${config.testerGroup}');

    print('\nFlavors:\n');

    config.flavors.forEach((key, value) {
      print('[$key]');
      print('Env: ${value.env}');
      print('Firebase: ${value.firebaseAppId}\n');
    });
  }
}
