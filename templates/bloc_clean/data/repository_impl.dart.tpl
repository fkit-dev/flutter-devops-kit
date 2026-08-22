import '../../domain/repositories/{{repositoryFile}}';
import '../datasources/local/{{localDatasourceFile}}';
import '../datasources/remote/{{remoteDatasourceFile}}';

// FKIT generated implementation point: compose datasources into repository behavior.
class {{repositoryImpl}} implements {{repository}} {
  const {{repositoryImpl}}({
    required {{remoteDatasource}} {{remoteDatasourceInstance}},
    required {{localDatasource}} {{localDatasourceInstance}},
  })  : _{{remoteDatasourceInstance}} = {{remoteDatasourceInstance}},
        _{{localDatasourceInstance}} = {{localDatasourceInstance}};

  final {{remoteDatasource}} _{{remoteDatasourceInstance}};

  final {{localDatasource}} _{{localDatasourceInstance}};

  // TODO: Implement repository methods.
}
