/// Generates consistent class names, file names, paths, and template variables
/// from feature and resource names.
///
/// Naming values are exposed in snake_case, camelCase, and PascalCase formats
/// for use by FKIT code-generation commands and templates.
class NamingService {
  /// The feature name used to generate feature-based naming values.
  final String feature;

  /// The optional resource name used for entity and data-layer components.
  final String? name;

  /// Creates a naming service for the specified [feature] and optional [name].
  NamingService({required this.feature, this.name});

// ---------------------------------------------------------------------------
// Feature
// ---------------------------------------------------------------------------

  /// The feature name formatted as snake_case.
  late final String featureSnake = _snake(feature);

  /// The feature name formatted as camelCase.
  late final String featureCamel = _camel(feature);

  /// The feature name formatted as PascalCase.
  late final String featurePascal = _pascal(feature);

// ---------------------------------------------------------------------------
// Resource
// ---------------------------------------------------------------------------

  /// The resource name used for resource-based naming values.
  ///
  /// Defaults to [feature] when [name] is not provided.
  late final String resourceName = name ?? feature;

  /// The resource name formatted as snake_case.
  late final String resourceSnake = _snake(resourceName);

  /// The resource name formatted as camelCase.
  late final String resourceCamel = _camel(resourceName);

  /// The resource name formatted as PascalCase.
  late final String resourcePascal = _pascal(resourceName);

// ---------------------------------------------------------------------------
// Bloc
// ---------------------------------------------------------------------------

  /// The generated Bloc class name.
  late final String bloc = _className(featurePascal, 'Bloc');

  /// The generated Bloc event class name.
  late final String event = _className(featurePascal, 'Event');

  /// The generated Bloc state class name.
  late final String state = _className(featurePascal, 'State');

// ---------------------------------------------------------------------------
// Repository
// ---------------------------------------------------------------------------

  /// The generated repository class name.
  late final String repository = _className(featurePascal, 'Repository');

  /// The generated repository implementation class name.
  late final String repositoryImpl = _className(featurePascal, 'RepositoryImpl');

// ---------------------------------------------------------------------------
// Datasource
// ---------------------------------------------------------------------------

  /// The generated remote datasource class name.
  late final String remoteDatasource = _className(featurePascal, 'RemoteDatasource');

  /// The generated remote datasource implementation class name.
  late final String remoteDatasourceImpl = _className(featurePascal, 'RemoteDatasourceImpl');

  /// The generated local datasource class name.
  late final String localDatasource = _className(featurePascal, 'LocalDatasource');

  /// The generated local datasource implementation class name.
  late final String localDatasourceImpl = _className(featurePascal, 'LocalDatasourceImpl');

// ---------------------------------------------------------------------------
// Resource Based
// ---------------------------------------------------------------------------

  /// The generated entity class name.
  late final String entity = _className(resourcePascal, 'Entity');

  /// The generated DTO class name.
  late final String dto = _className(resourcePascal, 'Dto');

  /// The generated mapper class name.
  late final String mapper = _className(resourcePascal, 'Mapper');

  /// The generated use case class name.
  late final String usecase = _className(resourcePascal, 'Usecase');

// ---------------------------------------------------------------------------
// File Names
// ---------------------------------------------------------------------------

  /// The generated Bloc event file name.
  late final String eventFile = '${featureSnake}_event.dart';

  /// The generated Bloc state file name.
  late final String stateFile = '${featureSnake}_state.dart';

  /// The generated repository file name.
  late final String repositoryFile = '${featureSnake}_repository.dart';

  /// The generated repository implementation file name.
  late final String repositoryImplFile = '${featureSnake}_repository_impl.dart';

  /// The generated remote datasource file name.
  late final String remoteDatasourceFile = '${featureSnake}_remote_datasource.dart';

  /// The generated remote datasource implementation file name.
  late final String remoteDatasourceImplFile = '${featureSnake}_remote_datasource_impl.dart';

  /// The generated local datasource file name.
  late final String localDatasourceFile = '${featureSnake}_local_datasource.dart';

  /// The generated local datasource implementation file name.
  late final String localDatasourceImplFile = '${featureSnake}_local_datasource_impl.dart';

  /// The generated entity file name.
  late final String entityFile = '${resourceSnake}_entity.dart';

  /// The generated DTO file name.
  late final String dtoFile = '${resourceSnake}_dto.dart';

  /// The generated mapper file name.
  late final String mapperFile = '${resourceSnake}_mapper.dart';

  /// The generated use case file name.
  late final String usecaseFile = '${resourceSnake}_usecase.dart';

  /// The generated Freezed entity implementation class name.
  late final String freezedEntity = '_\$$entity';

  /// The generated Freezed DTO implementation class name.
  late final String freezedDto = '_\$$dto';

  /// The generated JSON deserialization function name.
  late final String fromJson = '_\$${dto}FromJson';

  /// The generated JSON serialization function name.
  late final String toJson = '_\$${dto}ToJson';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

  String _snake(String value) {
    if (value.isEmpty) return '';
    return value
        .replaceAll('-', '')
        .replaceAll(' ', '')
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (match) => '${match.group(1)}${match.group(2)}',
        )
        .toLowerCase();
  }

  String _camel(String value) {
    final pascal = _pascal(value);
    if (pascal.isEmpty) return '';
    return pascal[0].toLowerCase() + pascal.substring(1);
  }

  String _pascal(String value) {
    if (value.isEmpty) return '';
    return value.split(RegExp(r'[-\s]+')).where((e) => e.isNotEmpty).map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase()).join();
  }

  String _instance(String className) {
    if (className.isEmpty) return '';

    return className[0].toLowerCase() + className.substring(1);
  }

  String _className(String base, String suffix) => '$base$suffix';

  /// The generated screen class name.
  late final String screen = _className(resourcePascal, 'Screen');

  /// The generated screen file name.
  late final String screenFile = '${resourceSnake}_screen.dart';

  /// The generated dependency injection class name.
  late final String di = _className(featurePascal, 'Di');

  /// The generated dependency injection file name.
  late final String diFile = '${featureSnake}_di.dart';

  /// The name of the generated xcore export file.
  late final String xcoreFile = 'xcore.dart';

  /// The entity file name without its Dart extension.
  late final String entityBase = '${resourceSnake}_entity';

  /// The DTO file name without its Dart extension.
  late final String dtoBase = '${resourceSnake}_dto';

  /// The mapper file name without its Dart extension.
  late final String mapperBase = '${resourceSnake}_mapper';

  /// The use case file name without its Dart extension.
  late final String usecaseBase = '${resourceSnake}_usecase';

  /// The generated feature directory path.
  late final String featurePath = 'lib/features/$featureSnake';

  /// The Bloc file name without its Dart extension.
  late final String blocBase = '${featureSnake}_bloc';

  /// The Bloc event file name without its Dart extension.
  late final String eventBase = '${featureSnake}_event';

  /// The Bloc state file name without its Dart extension.
  late final String stateBase = '${featureSnake}_state';

  /// The repository file name without its Dart extension.
  late final String repositoryBase = '${featureSnake}_repository';

  /// The repository implementation file name without its Dart extension.
  late final String repositoryImplBase = '${featureSnake}_repository_impl';

  /// The remote datasource file name without its Dart extension.
  late final String remoteDatasourceBase = '${featureSnake}_remote_datasource';

  /// The remote datasource implementation file name without its Dart extension.
  late final String remoteDatasourceImplBase = '${featureSnake}_remote_datasource_impl';

  /// The local datasource file name without its Dart extension.
  late final String localDatasourceBase = '${featureSnake}_local_datasource';

  /// The local datasource implementation file name without its Dart extension.
  late final String localDatasourceImplBase = '${featureSnake}_local_datasource_impl';

  /// The generated Bloc file name.
  late final String blocFile = '$blocBase.dart';

  /// The generated Bloc instance name.
  late final String blocInstance = _instance(bloc);

  /// The generated Bloc event instance name.
  late final String eventInstance = _instance(event);

  /// The generated Bloc state instance name.
  late final String stateInstance = _instance(state);

  /// The generated repository instance name.
  late final String repositoryInstance = _instance(repository);

  /// The generated repository implementation instance name.
  late final String repositoryImplInstance = _instance(repositoryImpl);

  /// The generated remote datasource instance name.
  late final String remoteDatasourceInstance = _instance(remoteDatasource);

  /// The generated remote datasource implementation instance name.
  late final String remoteDatasourceImplInstance = _instance(remoteDatasourceImpl);

  /// The generated local datasource instance name.
  late final String localDatasourceInstance = _instance(localDatasource);

  /// The generated local datasource implementation instance name.
  late final String localDatasourceImplInstance = _instance(localDatasourceImpl);

  /// The generated entity instance name.
  late final String entityInstance = _instance(entity);

  /// The generated DTO instance name.
  late final String dtoInstance = _instance(dto);

  /// The generated mapper instance name.
  late final String mapperInstance = _instance(mapper);

  /// The generated use case instance name.
  late final String usecaseInstance = _instance(usecase);

  /// The generated screen instance name.
  late final String screenInstance = _instance(screen);

  /// The generated dependency injection instance name.
  late final String diInstance = _instance(di);

  /// The screen file name without its Dart extension.
  late final String screenBase = '${featureSnake}_screen';

  /// The dependency injection file name without its Dart extension.
  late final String diBase = '${featureSnake}_di';

  /// The generated Freezed state implementation class name.
  late final String freezedState = '_\$$state';

  /// The generated Freezed event implementation class name.
  late final String freezedEvent = '_\$$event';

  /// The generated Freezed Bloc implementation class name.
  late final String freezedBloc = '_\$$bloc';

  /// Resolves the generated class name for the specified [component].
  ///
  /// Throws an [Exception] when the component is not available in [variables].
  String resolveClass(String component) {
    final value = variables[component];
    if (value == null) {
      throw Exception('Unknown component "$component".');
    }
    return value;
  }

  /// Resolves the generated variable name for the specified [component].
  ///
  /// The resolved class name is converted to lower camel case.
  String resolveVariable(String component) {
    final className = resolveClass(component);

    return className[0].toLowerCase() + className.substring(1);
  }

// ---------------------------------------------------------------------------
// Template Variables
// ---------------------------------------------------------------------------

  /// The generated naming values available to FKIT templates.
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
        'registerFeatureDependencies': 'register${featurePascal}Dependencies',
        'serviceLocator': 'getIt',

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
        'repository_impl': repositoryImpl,

        'remote_datasource': remoteDatasource,
        'remote_datasource_impl': remoteDatasourceImpl,

        'local_datasource': localDatasource,
        'local_datasource_impl': localDatasourceImpl,
      };
}
