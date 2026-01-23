import 'package:freezed_annotation/freezed_annotation.dart';

part 'resize_setting.freezed.dart';

@freezed
class ResizeSettings with _$ResizeSettings {
  const ResizeSettings._();

  const factory ResizeSettings({
    int? width,
    int? height,
    @Default(true) bool maintainAspectRatio,
  }) = _ResizeSettings;

  bool get isValid => width != null || height != null;
}
