import 'dart:io';

import 'package:flutter_devops_kit/generators/core/generator_context.dart';
import 'package:flutter_devops_kit/generators/feature/component_generator.dart';
import 'package:flutter_devops_kit/models/template/template_definition.dart';
import 'package:flutter_devops_kit/services/config/config_service.dart';
import 'package:flutter_devops_kit/services/maintenance_service.dart';
import 'package:flutter_devops_kit/services/project_setup_service.dart';
import 'package:flutter_devops_kit/services/template_service.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory originalDirectory;
  late Directory tempDirectory;
  late TemplateDefinition template;

  setUp(() async {
    originalDirectory = Directory.current;
    template = await TemplateService.load('bloc_clean');
    tempDirectory = await Directory.systemTemp.createTemp('fkit_fixture_');
    await _copyDirectory(
      Directory(p.join(originalDirectory.path, 'example/flutter_app')),
      tempDirectory,
    );
    Directory.current = tempDirectory;
  });

  tearDown(() async {
    Directory.current = originalDirectory;
    if (tempDirectory.existsSync()) {
      await tempDirectory.delete(recursive: true);
    }
  });

  test(
      'setup generates BLoC modules, bootstrap, localization, and feature files',
      () async {
    final config = await ConfigService.load();

    final completed = await const ProjectSetupService().setup(
      config: config,
      template: template,
      overwrite: true,
      runFlutterCommands: false,
    );

    expect(completed, isTrue);
    expect(File('lib/app/theme/app_theme.dart').existsSync(), isTrue);
    expect(File('lib/app/router/app_router.dart').existsSync(), isTrue);
    expect(File('lib/core/network/base_api_service.dart').existsSync(), isTrue);
    expect(File('lib/app/view/app.dart').existsSync(), isTrue);
    expect(File('lib/main.dart').existsSync(), isTrue);
    expect(File('l10n.yaml').existsSync(), isTrue);
    expect(File('lib/l10n/app_en.arb').existsSync(), isTrue);
    expect(File('lib/l10n/app_es.arb').existsSync(), isTrue);
    expect(
        File('lib/features/auth/presentation/bloc/auth_bloc.dart').existsSync(),
        isTrue);
    expect(
        File('lib/features/auth/domain/entities/auth_entity.dart').existsSync(),
        isTrue);
    expect(
        File('lib/features/auth/data/models/dtos/auth_dto.dart').existsSync(),
        isTrue);
    expect(
      File('lib/features/auth/data/models/mappers/auth_mapper.dart')
          .existsSync(),
      isTrue,
    );

    final app = await File('lib/app/view/app.dart').readAsString();
    expect(
      app,
      contains("import '../../gen/l10n/app_localizations.dart';"),
    );
    expect(
      app,
      contains(
          'localizationsDelegates: AppLocalizations.localizationsDelegates'),
    );
    expect(
      app,
      contains('supportedLocales: AppLocalizations.supportedLocales'),
    );
  });

  test('setup is duplicate-safe for localization and route maintenance',
      () async {
    final config = await ConfigService.load();
    final service = const ProjectSetupService();

    await service.setup(
      config: config,
      template: template,
      overwrite: true,
      runFlutterCommands: false,
    );

    final context = GeneratorContext(
      config: config,
      feature: 'auth',
      template: template,
    );
    await const MaintenanceService().synchronize(context);

    final app = await File('lib/app/view/app.dart').readAsString();
    expect(_count(app, 'app_localizations.dart'), 1);
    expect(_count(app, 'localizationsDelegates:'), 1);

    final router = await File('lib/app/router/app_router.dart').readAsString();
    final routes = await File('lib/app/router/app_route.dart').readAsString();
    expect(_count(router, 'AuthScreen'), 1);
    expect(_count(routes, "auth('/auth')"), 1);
  });

  test('component generation overwrites with force semantics', () async {
    final config = await ConfigService.load();

    await const ProjectSetupService().setup(
      config: config,
      template: template,
      overwrite: true,
      runFlutterCommands: false,
    );

    final screen =
        File('lib/features/auth/presentation/screens/auth_screen.dart');
    await screen.writeAsString('// stale file');

    final context = GeneratorContext(
      config: config,
      feature: 'auth',
      template: template,
    );
    await const ComponentGenerator().generate(
      context: context,
      component: 'screen',
      overwrite: true,
    );

    expect(await screen.readAsString(), contains('class AuthScreen'));
  });

  test('template validation includes setup dependency requirements', () async {
    expect(template.requirements.packages, contains('flutter_bloc'));
    expect(template.requirements.packages, contains('freezed_annotation'));
    expect(template.requirements.packages, contains('json_annotation'));
    expect(template.requirements.devPackages, contains('build_runner'));
    expect(template.requirements.devPackages, contains('freezed'));
    expect(template.requirements.devPackages, contains('json_serializable'));
  });
}

Future<void> _copyDirectory(Directory source, Directory target) async {
  await for (final entity in source.list(recursive: false)) {
    final targetPath = p.join(target.path, p.basename(entity.path));
    if (entity is Directory) {
      await _copyDirectory(entity, Directory(targetPath)..createSync());
    } else if (entity is File) {
      await entity.copy(targetPath);
    }
  }
}

int _count(String value, String pattern) => pattern.allMatches(value).length;
