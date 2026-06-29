import 'dart:io';

import '../services/logger_service.dart';
import '../services/prompt_service.dart';
import '../utils/command_executor.dart';

class SigningService {
  Future<void> setup() async {
    LoggerService.section('Android Signing Setup');

    final alias = PromptService.ask('Keystore alias', defaultValue: 'fkit.jks');

    final storePassword = PromptService.ask('Store password', defaultValue: 'Fkit@1215');

    final keyPassword = PromptService.ask('Key password', defaultValue: 'Fkit@1215');

    final company = PromptService.ask('Company/Organization', defaultValue: 'Fkit');

    final keystoreName = '$alias-keystore.jks';

    final keystorePath = 'android/app/$keystoreName';

    final keyPropertiesPath = 'android/key.properties';

    final keystoreFile = File(keystorePath);

    if (keystoreFile.existsSync()) {
      final overwrite = PromptService.confirm('Keystore already exists. Overwrite?');

      if (!overwrite) {
        LoggerService.warning('Operation cancelled.');

        return;
      }

      keystoreFile.deleteSync();
    }

    LoggerService.command('Generating keystore...');

    await CommandExecutor.run('keytool', [
      '-genkey',
      '-v',
      '-keystore',
      keystorePath,
      '-keyalg',
      'RSA',
      '-keysize',
      '2048',
      '-validity',
      '10000',
      '-alias',
      alias,
      '-storepass',
      storePassword,
      '-keypass',
      keyPassword,
      '-dname',
      'CN=$company, OU=Mobile, O=$company, L=Mumbai, S=Maharashtra, C=IN',
    ]);

    LoggerService.success('Keystore generated');

    final keyProperties = '''
storePassword=$storePassword
keyPassword=$keyPassword
keyAlias=$alias
storeFile=$keystoreName
''';

    await File(keyPropertiesPath).writeAsString(keyProperties);

    LoggerService.success('key.properties created');

    await _updateGitignore();

    LoggerService.success('.gitignore updated');

    LoggerService.blank();

    LoggerService.info('Keystore: $keystorePath');

    LoggerService.info('Properties: $keyPropertiesPath');

    LoggerService.blank();

    LoggerService.warning('Next step:');

    LoggerService.info('Configure signingConfigs in Gradle.');
  }

  Future<void> doctor() async {
    LoggerService.section('Signing Doctor');

    final keyProperties = File('android/key.properties');

    if (!keyProperties.existsSync()) {
      LoggerService.error('android/key.properties missing');

      return;
    }

    LoggerService.success('key.properties found');

    final content = await keyProperties.readAsString();

    final storeFileMatch = RegExp(r'storeFile=(.*)').firstMatch(content);

    if (storeFileMatch == null) {
      LoggerService.error('storeFile missing in key.properties');

      return;
    }

    final storeFile = storeFileMatch.group(1)!.trim();

    final keystorePath = 'android/app/$storeFile';

    if (!File(keystorePath).existsSync()) {
      LoggerService.error('Keystore missing: $keystorePath');

      return;
    }

    LoggerService.success('Keystore found');

    final gradleKts = File('android/app/build.gradle.kts');

    final gradleGroovy = File('android/app/build.gradle');

    if (!gradleKts.existsSync() && !gradleGroovy.existsSync()) {
      LoggerService.error('Gradle build file not found');

      return;
    }

    LoggerService.success('Gradle file found');

    LoggerService.blank();

    LoggerService.success('Signing setup looks valid.');
  }

  Future<void> _updateGitignore() async {
    final gitignore = File('.gitignore');

    if (!gitignore.existsSync()) {
      gitignore.createSync();
    }

    final content = await gitignore.readAsString();

    final entries = ['android/key.properties', 'android/app/*.jks', 'android/app/*.keystore'];

    final buffer = StringBuffer(content);

    for (final entry in entries) {
      if (!content.contains(entry)) {
        buffer.writeln(entry);
      }
    }

    await gitignore.writeAsString(buffer.toString());
  }
}
