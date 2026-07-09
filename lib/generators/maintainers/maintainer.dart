import '../core/generator_context.dart';

abstract interface class Maintainer {
  const Maintainer();

  Future<void> maintain(GeneratorContext context);
}
