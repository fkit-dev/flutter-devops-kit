import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';
part 'error_model.g.dart';

@freezed
sealed class ErrorModel with _$ErrorModel {
  const factory ErrorModel({
    String? title,
    String? subTitle,
    String? image,
    String? urlLabel,
    String? redirectionUrl,
    bool? isButtonEnable,
    bool? isRestartRequired,
    String? buttonText,
  }) = _ErrorModel;

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
}