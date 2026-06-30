class NamingService {
  final String feature;
  final String? name;
  NamingService({required this.feature, this.name});
  // --------------------------------------------------------------------------- // Feature // ---------------------------------------------------------------------------
  late final String featureSnake = _snake(feature);
  late final String featureCamel = _camel(feature);
  late final String featurePascal = _pascal(feature);
// --------------------------------------------------------------------------- // Resource (Entity / DTO / Usecase etc.) // ---------------------------------------------------------------------------
  late final String resourceName = name ?? feature;
  late final String resourceSnake = _snake(resourceName);
  late final String resourceCamel = _camel(resourceName);
  late final String resourcePascal = _pascal(resourceName);
// --------------------------------------------------------------------------- // Bloc // ---------------------------------------------------------------------------
  late final String bloc = _className(featurePascal, 'Bloc');
  late final String event = _className(featurePascal, 'Event');
  late final String state = _className(featurePascal, 'State');
// --------------------------------------------------------------------------- // Repository // ---------------------------------------------------------------------------
  late final String repository = _className(featurePascal, 'Repository');
  late final String repositoryImpl = _className(featurePascal, 'RepositoryImpl');
// --------------------------------------------------------------------------- // Datasource // ---------------------------------------------------------------------------
  late final String remoteDatasource = _className(featurePascal, 'RemoteDatasource');
  late final String remoteDatasourceImpl = _className(featurePascal, 'RemoteDatasourceImpl');
  late final String localDatasource = _className(featurePascal, 'LocalDatasource');
  late final String localDatasourceImpl = _className(featurePascal, 'LocalDatasourceImpl');
// --------------------------------------------------------------------------- // Resource Based // ---------------------------------------------------------------------------
  late final String entity = _className(resourcePascal, 'Entity');
  late final String dto = _className(resourcePascal, 'Dto');
  late final String mapper = _className(resourcePascal, 'Mapper');
  late final String usecase = _className(resourcePascal, 'Usecase');
// --------------------------------------------------------------------------- // File Names // ---------------------------------------------------------------------------
  late final String eventFile = '${featureSnake}_event.dart';
  late final String stateFile = '${featureSnake}_state.dart';
  late final String repositoryFile = '${featureSnake}_repository.dart';
  late final String repositoryImplFile = '${featureSnake}_repository_impl.dart';
  late final String remoteDatasourceFile = '${featureSnake}_remote_datasource.dart';
  late final String remoteDatasourceImplFile = '${featureSnake}_remote_datasource_impl.dart';
  late final String localDatasourceFile = '${featureSnake}_local_datasource.dart';
  late final String localDatasourceImplFile = '${featureSnake}_local_datasource_impl.dart';
  late final String entityFile = '${resourceSnake}_entity.dart';
  late final String dtoFile = '${resourceSnake}_dto.dart';
  late final String mapperFile = '${resourceSnake}_mapper.dart';
  late final String usecaseFile = '${resourceSnake}_usecase.dart';
  late final String freezedEntity = '_\$$entity';
  late final String freezedDto = '_\$$dto';
  late final String fromJson = '_\$${dto}FromJson';
  late final String toJson = '_\$${dto}ToJson';
// --------------------------------------------------------------------------- // Helpers // ---------------------------------------------------------------------------
  String _snake(String value) {
    if (value.isEmpty) return '';
    return value
        .replaceAll('-', '_')
        .replaceAll(' ', '_')
        .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (match) => '${match.group(1)}_${match.group(2)}')
        .toLowerCase();
  }

  String _camel(String value) {
    final pascal = _pascal(value);
    if (pascal.isEmpty) return '';
    return pascal[0].toLowerCase() + pascal.substring(1);
  }

  String _pascal(String value) {
    if (value.isEmpty) return '';
    return value.split(RegExp(r'[_\-\s]+')).where((e) => e.isNotEmpty).map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase()).join();
  }

  String _instance(String className) {
    if (className.isEmpty) return '';

    return className[0].toLowerCase() + className.substring(1);
  }

  String _className(String base, String suffix) => '$base$suffix';
  late final String screen = _className(resourcePascal, 'Screen');
  late final String screenFile = '${resourceSnake}_screen.dart';
  late final String di = _className(featurePascal, 'Di');
  late final String diFile = '${featureSnake}_di.dart';
  late final String xcoreFile = 'xcore.dart';
  late final String entityBase = '${resourceSnake}_entity';
  late final String dtoBase = '${resourceSnake}_dto';
  late final String mapperBase = '${resourceSnake}_mapper';
  late final String usecaseBase = '${resourceSnake}_usecase';
  late final String featurePath = 'lib/features/$featureSnake';
  late final String blocBase = '${featureSnake}_bloc';
  late final String eventBase = '${featureSnake}_event';
  late final String stateBase = '${featureSnake}_state';
  late final String repositoryBase = '${featureSnake}_repository';
  late final String repositoryImplBase = '${featureSnake}_repository_impl';
  late final String remoteDatasourceBase = '${featureSnake}_remote_datasource';
  late final String remoteDatasourceImplBase = '${featureSnake}_remote_datasource_impl';
  late final String localDatasourceBase = '${featureSnake}_local_datasource';
  late final String localDatasourceImplBase = '${featureSnake}_local_datasource_impl';
  late final String blocFile = '$blocBase.dart';

  late final String blocInstance = _instance(bloc);
  late final String eventInstance = _instance(event);
  late final String stateInstance = _instance(state);

  late final String repositoryInstance = _instance(repository);
  late final String repositoryImplInstance = _instance(repositoryImpl);

  late final String remoteDatasourceInstance = _instance(remoteDatasource);
  late final String remoteDatasourceImplInstance = _instance(remoteDatasourceImpl);
  late final String localDatasourceInstance = _instance(localDatasource);
  late final String localDatasourceImplInstance = _instance(localDatasourceImpl);

  late final String entityInstance = _instance(entity);
  late final String dtoInstance = _instance(dto);
  late final String mapperInstance = _instance(mapper);
  late final String usecaseInstance = _instance(usecase);

  late final String screenInstance = _instance(screen);
  late final String diInstance = _instance(di);

  late final String screenBase = '${featureSnake}_screen';
  late final String diBase = '${featureSnake}_di';

  late final String freezedState = '_\$$state';
  late final String freezedEvent = '_\$$event';
  late final String freezedBloc = '_\$$bloc';

  // --------------------------------------------------------------------------- // Template Variables // ---------------------------------------------------------------------------
  Map<String, String> get variables => {
        // ---------------------------------------------------------------------------
        // Feature
        // ---------------------------------------------------------------------------

        'feature': featureSnake,
        'featureName': feature,
        'featureSnake': featureSnake,
        'featureCamel': featureCamel,
        'featurePascal': featurePascal,
        'featurePath': featurePath,

        // ---------------------------------------------------------------------------
        // Resource
        // ---------------------------------------------------------------------------

        'resource': resourceSnake,
        'resourceName': resourceName,
        'resourceSnake': resourceSnake,
        'resourceCamel': resourceCamel,
        'resourcePascal': resourcePascal,

        // ---------------------------------------------------------------------------
        // Bloc
        // ---------------------------------------------------------------------------

        'bloc': bloc,
        'blocCamel': blocInstance,
        'blocBase': blocBase,
        'blocFile': blocFile,

        'event': event,
        'eventCamel': eventInstance,
        'eventBase': eventBase,
        'eventFile': eventFile,

        'state': state,
        'stateCamel': stateInstance,
        'stateBase': stateBase,
        'stateFile': stateFile,

        // ---------------------------------------------------------------------------
        // Repository
        // ---------------------------------------------------------------------------

        'repository': repository,
        'repositoryCamel': repositoryInstance,
        'repositoryBase': repositoryBase,
        'repositoryFile': repositoryFile,

        'repositoryImpl': repositoryImpl,
        'repositoryImplCamel': repositoryImplInstance,
        'repositoryImplBase': repositoryImplBase,
        'repositoryImplFile': repositoryImplFile,

        'repositoryInstance': repositoryInstance,
        'repositoryImplInstance': repositoryImplInstance,

        'remoteDatasourceInstance': remoteDatasourceInstance,
        'remoteDatasourceImplInstance': remoteDatasourceImplInstance,

        'localDatasourceInstance': localDatasourceInstance,
        'localDatasourceImplInstance': localDatasourceImplInstance,

        'usecaseInstance': usecaseInstance,

        // ---------------------------------------------------------------------------
        // Datasources
        // ---------------------------------------------------------------------------

        'remoteDatasource': remoteDatasource,
        'remoteDatasourceCamel': remoteDatasourceInstance,
        'remoteDatasourceBase': remoteDatasourceBase,
        'remoteDatasourceFile': remoteDatasourceFile,

        'remoteDatasourceImpl': remoteDatasourceImpl,
        'remoteDatasourceImplCamel': remoteDatasourceImplInstance,
        'remoteDatasourceImplBase': remoteDatasourceImplBase,
        'remoteDatasourceImplFile': remoteDatasourceImplFile,

        'localDatasource': localDatasource,
        'localDatasourceCamel': localDatasourceInstance,
        'localDatasourceBase': localDatasourceBase,
        'localDatasourceFile': localDatasourceFile,

        'localDatasourceImpl': localDatasourceImpl,
        'localDatasourceImplCamel': localDatasourceImplInstance,
        'localDatasourceImplBase': localDatasourceImplBase,
        'localDatasourceImplFile': localDatasourceImplFile,

        // ---------------------------------------------------------------------------
        // Domain
        // ---------------------------------------------------------------------------

        'entity': entity,
        'entityCamel': entityInstance,
        'entityBase': entityBase,
        'entityFile': entityFile,

        'dto': dto,
        'dtoCamel': dtoInstance,
        'dtoBase': dtoBase,
        'dtoFile': dtoFile,

        'mapper': mapper,
        'mapperCamel': mapperInstance,
        'mapperBase': mapperBase,
        'mapperFile': mapperFile,

        'usecase': usecase,
        'usecaseCamel': usecaseInstance,
        'usecaseBase': usecaseBase,
        'usecaseFile': usecaseFile,

        // ---------------------------------------------------------------------------
        // Presentation
        // ---------------------------------------------------------------------------

        'screen': screen,
        'screenCamel': screenInstance,
        'screenBase': screenBase,
        'screenFile': screenFile,

        // ---------------------------------------------------------------------------
        // Dependency Injection
        // ---------------------------------------------------------------------------

        'di': di,
        'diCamel': diInstance,
        'diBase': diBase,
        'diFile': diFile,

        // ---------------------------------------------------------------------------
        // Feature
        // ---------------------------------------------------------------------------

        'xcoreFile': xcoreFile,

        // ---------------------------------------------------------------------------
        // Freezed
        // ---------------------------------------------------------------------------

        'freezedEntity': freezedEntity,
        'freezedDto': freezedDto,
        'freezedBloc': freezedBloc,
        'freezedEvent': freezedEvent,
        'freezedState': freezedState,

        // ---------------------------------------------------------------------------
        // JSON Serialization
        // ---------------------------------------------------------------------------

        'fromJson': fromJson,
        'toJson': toJson,
      };
}
