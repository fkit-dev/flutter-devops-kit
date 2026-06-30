import 'package:freezed_annotation/freezed_annotation.dart';

part '{{stateBase}}.freezed.dart';

@freezed
sealed class {{state}} with {{freezedState}} {
  const factory {{state}}.initial() = {{featurePascal}}Initial;

  const factory {{state}}.loading() = {{featurePascal}}Loading;

  const factory {{state}}.success() = {{featurePascal}}Success;

  const factory {{state}}.failure({
    required String message,
  }) = {{featurePascal}}Failure;
}