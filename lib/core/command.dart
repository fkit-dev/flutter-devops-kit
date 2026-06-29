import 'command_category.dart';

abstract class Command {
  String get name;
  String get description;
  CommandCategory get category;
  String get usage;
  List<String> get examples => const [];
  List<String> get aliases => const [];
  bool get hidden => false;
  bool get experimental => false;
  bool get requiresConfig => false;
  bool get requiresFlutterProject => false;
  Future<void> run(List<String> args);
}
