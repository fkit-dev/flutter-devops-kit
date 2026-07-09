import '../../../models/init_config.dart';

abstract class GeneratorSection {
  void write(
    StringBuffer buffer,
    InitConfig config,
  );
}
