import '../generators/core/generator_context.dart';
import '../generators/maintainers/barrel_maintainer.dart';
import '../generators/maintainers/di_maintainer.dart';
import '../generators/maintainers/route_maintainer.dart';

class MaintenanceService {
  const MaintenanceService();

  Future<void> synchronize(GeneratorContext context) async {
    await BarrelMaintainer().maintain(context);
    await const DiMaintainer().maintain(context);
    await const RouteMaintainer().maintain(context);
  }
}
