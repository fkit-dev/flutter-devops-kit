import 'dart:io';

import 'package:flutter_devops_kit/analyzer/models/constructor_resolver.dart';
import 'package:test/test.dart';

void main() {
  late Directory tempDir;
  late ConstructorResolver resolver;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('fkit_test_');
    resolver = const ConstructorResolver();
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  Future<File> writeFile(String content) async {
    final file = File('${tempDir.path}/test_class.dart');
    await file.writeAsString(content);
    return file;
  }

  group('ConstructorResolver', () {
    test('resolves named parameters', () async {
      final file = await writeFile('''
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  const AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });
}
''');
      final params = await resolver.resolve(file);
      expect(params.length, 2);
      expect(params[0].name, 'remoteDatasource');
      expect(params[0].isRequired, isTrue);
      expect(params[1].name, 'localDatasource');
      expect(params[1].isRequired, isTrue);
    });

    test('resolves optional named parameters', () async {
      final file = await writeFile('''
class Config {
  final String name;
  final int? age;

  const Config({
    required this.name,
    this.age,
  });
}
''');
      final params = await resolver.resolve(file);
      expect(params.length, 2);
      expect(params[0].name, 'name');
      expect(params[0].isRequired, isTrue);
      expect(params[1].name, 'age');
      expect(params[1].isRequired, isFalse);
    });

    test('returns empty list for non-existent file', () async {
      final file = File('${tempDir.path}/nonexistent.dart');
      final params = await resolver.resolve(file);
      expect(params, isEmpty);
    });

    test('returns empty list when file has no constructor', () async {
      final file = await writeFile('''
class EmptyClass {
  void doSomething() {}
}
''');
      final params = await resolver.resolve(file);
      expect(params, isEmpty);
    });

    test('returns empty list for constructor without named params', () async {
      final file = await writeFile('''
class PositionalClass {
  final String name;

  const PositionalClass(this.name);
}
''');
      final params = await resolver.resolve(file);
      expect(params, isEmpty);
    });

    test('handles empty constructor body', () async {
      final file = await writeFile('''
class EmptyConstructor {
  const EmptyConstructor({});
}
''');
      final params = await resolver.resolve(file);
      expect(params, isEmpty);
    });

    test('handles single parameter constructor', () async {
      final file = await writeFile('''
class SingleParam {
  final String value;

  const SingleParam({required this.value});
}
''');
      final params = await resolver.resolve(file);
      expect(params.length, 1);
      expect(params[0].name, 'value');
    });

    test('handles const constructor with multiple params', () async {
      final file = await writeFile('''
class MultiParam {
  final String a;
  final int b;
  final bool c;

  const MultiParam({
    required this.a,
    required this.b,
    required this.c,
  });
}
''');
      final params = await resolver.resolve(file);
      expect(params.length, 3);
      expect(params[0].name, 'a');
      expect(params[1].name, 'b');
      expect(params[2].name, 'c');
    });
  });
}
