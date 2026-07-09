import 'paginated_result.dart';
import 'result.dart';

abstract class ResponseMapper<T> {
  const ResponseMapper();

  T fromJson(dynamic json);
}

class ObjectMapper<T> extends ResponseMapper<T> {
  const ObjectMapper(this.parser);

  final T Function(Map<String, dynamic>) parser;

  @override
  T fromJson(dynamic json) {
    return parser(
      Map<String, dynamic>.from(json as Map),
    );
  }
}

class ListMapper<T> extends ResponseMapper<List<T>> {
  const ListMapper(this.parser);

  final T Function(Map<String, dynamic>) parser;

  @override
  List<T> fromJson(dynamic json) {
    final list = json as List;

    return list
        .map(
          (item) => parser(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }
}

class PaginatedMapper<T>
    extends ResponseMapper<PaginatedResult<T>> {
  const PaginatedMapper(this.parser);

  final T Function(Map<String, dynamic>) parser;

  @override
  PaginatedResult<T> fromJson(dynamic json) {
    final list = json as List;

    final items = list
        .map(
          (item) => parser(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();

    return PaginatedResult<T>(
      items: items,
    );
  }
}

class ResultMapper<T> extends ResponseMapper<Result<T>> {
  const ResultMapper(this.parser);

  final T Function(Map<String, dynamic>) parser;

  @override
  Result<T> fromJson(dynamic json) {
    if (json is Map) {
      final map = Map<String, dynamic>.from(json);

      final data = map['data'];

      if (data is Map) {
        return Result<T>(
          data: parser(
            Map<String, dynamic>.from(data),
          ),
          message: map['message']?.toString(),
        );
      }

      return Result<T>(
        message: map['message']?.toString(),
      );
    }

    return Result<T>();
  }
}