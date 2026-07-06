import '../core/command.dart';
import '../core/command_category.dart';
import '../core/package_version.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/launcher_icon_service.dart';
import '../services/logger_service.dart';
import '../services/pubspec_service.dart';

class IconCommand extends Command {
  @override
  String get name => 'icon';

  @override
  String get description => 'Launcher icon utilities';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit icon <generate|configure|doctor>';

  @override
  List<String> get examples => const ['fkit icon generate', 'fkit icon configure', 'fkit icon doctor'];

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    if (args.isEmpty) {
      LoggerService.error('Usage: $usage');
      return;
    }

    switch (args.first) {
      case 'generate':
        await _generate();
        break;

      case 'configure':
        await _configure();
        break;

      case 'doctor':
        await _doctor();
        break;

      default:
        LoggerService.error('Unknown command "${args.first}".');
        LoggerService.blank();
        LoggerService.info('Supported commands:');
        LoggerService.blank();
        LoggerService.info('generate');
        LoggerService.info('configure');
        LoggerService.info('doctor');
    }
  }

  Future<void> _generate() async {
    final service = LauncherIconService();

    if (!await service.exists()) {
      LoggerService.info('Launcher icon configuration not found.');
      LoggerService.blank();

      final config = await service.configure();
      await service.save(config);
    }

    final issues = await service.validate();

    if (issues.isNotEmpty) {
      LoggerService.error('Launcher icon configuration contains errors.');
      LoggerService.blank();

      for (final issue in issues) {
        LoggerService.error(issue);
      }

      return;
    }

    final pubspec = PubspecService();
    await pubspec.ensureDevDependency('flutter_launcher_icons', version: PackageVersion.flutterLauncherIcons, ensureLoaded: true);
    await pubspec.save();

    final config = await ConfigService.load();

    await FlutterService(config).launcherIcons();

    LoggerService.blank();
    LoggerService.success('Launcher icons generated successfully.');
    LoggerService.blank();
  }

  Future<void> _configure() async {
    final service = LauncherIconService();

    final config = await service.configure();

    await service.save(config);

    LoggerService.blank();
    LoggerService.success('Launcher icon configuration updated.');
    LoggerService.blank();
  }

  Future<void> _doctor() async {
    final service = LauncherIconService();

    if (!await service.exists()) {
      LoggerService.error('flutter_launcher_icons.yaml not found.');
      return;
    }

    final issues = await service.validate();

    LoggerService.blank();

    if (issues.isEmpty) {
      LoggerService.success('Launcher icon configuration is valid.');
      LoggerService.blank();
      return;
    }

    LoggerService.error('Launcher icon configuration contains errors.');
    LoggerService.blank();

    for (final issue in issues) {
      LoggerService.error(issue);
    }

    LoggerService.blank();
  }
}
