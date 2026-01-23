import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/const/image_format.dart';

part 'conversion_settings.freezed.dart';

@freezed
class ConversionSettings with _$ConversionSettings {
  const factory ConversionSettings({
    required ImageFormat targetFormat,
    @Default(90) int quality,
  }) = _ConversionSettings;
}
