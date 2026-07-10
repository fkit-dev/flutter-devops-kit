import 'package:flutter_devops_kit/services/naming_service.dart';
import 'package:test/test.dart';

void main() {
  group('NamingService', () {
    group('feature naming', () {
      test('simple feature name', () {
        final n = NamingService(feature: 'auth');
        expect(n.featureSnake, 'auth');
        expect(n.featureCamel, 'auth');
        expect(n.featurePascal, 'Auth');
      });

      test('camelCase feature name', () {
        final n = NamingService(feature: 'userProfile');
        expect(n.featureSnake, 'user_profile');
        expect(n.featureCamel, 'userProfile');
        expect(n.featurePascal, 'UserProfile');
      });

      test('consecutive uppercase in feature name', () {
        final n = NamingService(feature: 'APIClient');
        expect(n.featureSnake, 'apiclient');
        expect(n.featureCamel, 'apiclient');
        expect(n.featurePascal, 'Apiclient');
      });

      test('hyphenated feature name', () {
        final n = NamingService(feature: 'user-profile');
        expect(n.featureSnake, 'user_profile');
        expect(n.featureCamel, 'userProfile');
        expect(n.featurePascal, 'UserProfile');
      });

      test('feature name with trailing acronym', () {
        final n = NamingService(feature: 'getAPI');
        expect(n.featureSnake, 'get_api');
        expect(n.featureCamel, 'getApi');
        expect(n.featurePascal, 'GetApi');
      });

      test('multi-word camelCase feature', () {
        final n = NamingService(feature: 'myAwesomeFeature');
        expect(n.featureSnake, 'my_awesome_feature');
        expect(n.featureCamel, 'myAwesomeFeature');
        expect(n.featurePascal, 'MyAwesomeFeature');
      });
    });

    group('resource naming', () {
      test('resource name defaults to feature when not provided', () {
        final n = NamingService(feature: 'auth');
        expect(n.resourceSnake, 'auth');
        expect(n.resourceCamel, 'auth');
        expect(n.resourcePascal, 'Auth');
      });

      test('resource name with explicit name', () {
        final n = NamingService(feature: 'auth', name: 'LoginRequest');
        expect(n.resourceSnake, 'login_request');
        expect(n.resourceCamel, 'loginRequest');
        expect(n.resourcePascal, 'LoginRequest');
      });

      test('resource name with snake_case name', () {
        final n = NamingService(feature: 'auth', name: 'login_request');
        expect(n.resourceSnake, 'login_request');
        expect(n.resourceCamel, 'loginRequest');
        expect(n.resourcePascal, 'LoginRequest');
      });
    });

    group('class names', () {
      test('bloc class names', () {
        final n = NamingService(feature: 'auth');
        expect(n.bloc, 'AuthBloc');
        expect(n.event, 'AuthEvent');
        expect(n.state, 'AuthState');
      });

      test('repository class names', () {
        final n = NamingService(feature: 'auth');
        expect(n.repository, 'AuthRepository');
        expect(n.repositoryImpl, 'AuthRepositoryImpl');
      });

      test('datasource class names', () {
        final n = NamingService(feature: 'auth');
        expect(n.remoteDatasource, 'AuthRemoteDatasource');
        expect(n.localDatasource, 'AuthLocalDatasource');
      });

      test('entity and dto class names', () {
        final n = NamingService(feature: 'auth', name: 'User');
        expect(n.entity, 'UserEntity');
        expect(n.dto, 'UserDto');
        expect(n.mapper, 'UserMapper');
        expect(n.usecase, 'UserUsecase');
      });

      test('screen and di class names', () {
        final n = NamingService(feature: 'auth', name: 'Login');
        expect(n.screen, 'LoginScreen');
        expect(n.di, 'AuthDi');
      });
    });

    group('file names', () {
      test('bloc file names', () {
        final n = NamingService(feature: 'auth');
        expect(n.blocFile, 'auth_bloc.dart');
        expect(n.eventFile, 'auth_event.dart');
        expect(n.stateFile, 'auth_state.dart');
      });

      test('repository file names', () {
        final n = NamingService(feature: 'userProfile');
        expect(n.repositoryFile, 'user_profile_repository.dart');
        expect(n.repositoryImplFile, 'user_profile_repository_impl.dart');
      });

      test('datasource file names', () {
        final n = NamingService(feature: 'userProfile');
        expect(n.remoteDatasourceFile, 'user_profile_remote_datasource.dart');
        expect(n.localDatasourceFile, 'user_profile_local_datasource.dart');
      });

      test('entity and dto file names with resource name', () {
        final n = NamingService(feature: 'auth', name: 'LoginRequest');
        expect(n.entityFile, 'login_request_entity.dart');
        expect(n.dtoFile, 'login_request_dto.dart');
        expect(n.usecaseFile, 'login_request_usecase.dart');
      });

      test('screen and di file names', () {
        final n = NamingService(feature: 'auth');
        expect(n.screenFile, 'auth_screen.dart');
        expect(n.diFile, 'auth_di.dart');
      });
    });

    group('template variables', () {
      test('contains all expected keys', () {
        final n = NamingService(feature: 'auth', name: 'Login');
        final vars = n.variables;

        expect(vars, containsPair('feature', 'auth'));
        expect(vars, containsPair('featureName', 'auth'));
        expect(vars, containsPair('featureSnake', 'auth'));
        expect(vars, containsPair('featureCamel', 'auth'));
        expect(vars, containsPair('featurePascal', 'Auth'));

        expect(vars, containsPair('resource', 'login'));
        expect(vars, containsPair('resourcePascal', 'Login'));

        expect(vars, containsPair('bloc', 'AuthBloc'));
        expect(vars, containsPair('event', 'AuthEvent'));
        expect(vars, containsPair('state', 'AuthState'));

        expect(vars, containsPair('repository', 'AuthRepository'));
        expect(vars, containsPair('repositoryImpl', 'AuthRepositoryImpl'));

        expect(vars, containsPair('entity', 'LoginEntity'));
        expect(vars, containsPair('dto', 'LoginDto'));
        expect(vars, containsPair('usecase', 'LoginUsecase'));

        expect(vars, containsPair('screen', 'LoginScreen'));
        expect(vars, containsPair('di', 'AuthDi'));
      });

      test('featurePath is correct', () {
        final n = NamingService(feature: 'auth');
        expect(n.featurePath, 'lib/features/auth');
      });
    });

    group('empty feature edge case', () {
      test('empty feature produces empty names', () {
        final n = NamingService(feature: '');
        expect(n.featureSnake, '');
        expect(n.featureCamel, '');
        expect(n.featurePascal, '');
        expect(n.bloc, 'Bloc');
      });
    });
  });
}
