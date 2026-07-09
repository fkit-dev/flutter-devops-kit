import 'package:freezed_annotation/freezed_annotation.dart';

part '{{dtoBase}}.freezed.dart';
part '{{dtoBase}}.g.dart';

@freezed
sealed class {{dto}} with {{freezedDto}} {
  const factory {{dto}}() = _{{dto}};

  factory {{dto}}.fromJson(
    Map<String, dynamic> json,
  ) =>
      {{fromJson}}(json);
}