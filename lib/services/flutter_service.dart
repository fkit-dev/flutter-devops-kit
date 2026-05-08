import '../models/project_config.dart';

class FlutterService {
  final ProjectConfig config;

  FlutterService(this.config);

  List<String> get flutterCommand {
    if (config.useFvm) {
      return ['fvm', 'flutter'];
    }

    return ['flutter'];
  }

  List<String> get dartCommand {
    if (config.useFvm) {
      return ['fvm', 'dart'];
    }

    return ['dart'];
  }
}
