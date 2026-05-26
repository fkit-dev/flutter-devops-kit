import '../utils/command_executor.dart';
import 'logger_service.dart';

class FirebaseService {
  Future<void> upload({required String appId, required String artifactPath, required String testerGroup, required String notes}) async {
    LoggerService.section('Uploading build to Firebase App Distribution');
    await CommandExecutor.run('firebase', [
      'appdistribution:distribute',
      artifactPath,
      '--app',
      appId,
      '--groups',
      testerGroup,
      '--release-notes',
      notes,
    ]);
    LoggerService.blank();

    LoggerService.success('Firebase upload complete.');

    LoggerService.blank();
  }
}
