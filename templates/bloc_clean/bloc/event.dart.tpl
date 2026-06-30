import 'package:freezed_annotation/freezed_annotation.dart';

part '{{eventBase}}.freezed.dart';

@freezed
sealed class {{event}} with {{freezedEvent}} {
  const factory {{event}}.started() = {{featurePascal}}Started;
}