import 'package:flutter_devops_kit/models/init_config.dart';
import 'package:flutter_devops_kit/services/template_service.dart';
import 'package:test/test.dart';

void main() {
  group('TemplateService', () {
    test('loads the production BLoC template', () async {
      final template = await TemplateService.load('bloc_clean');

      expect(template.name, 'bloc_clean');
      expect(template.components, isNotEmpty);
      expect(template.feature.files, isNotEmpty);
    });

    test('reports empty templates as unavailable', () async {
      expect(
        () => TemplateService.load('riverpod_clean'),
        throwsA(
          predicate<Exception>(
            (error) => error.toString().contains('template.yaml is empty'),
          ),
        ),
      );
    });

    test('lists only templates with manifests', () async {
      final templates = await TemplateService.availableTemplates();

      expect(templates, contains('bloc_clean'));
      expect(templates, isNot(contains('riverpod_clean')));
      expect(templates, isNot(contains('mvvm')));
    });
  });

  test('defaults to the production template', () {
    final config = InitConfig.fromMap({});

    expect(config.defaultTemplate, 'bloc_clean');
  });
}
