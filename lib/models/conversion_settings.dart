import '../const/image_format.dart';

class ConversionSettings {
  final ImageFormat targetFormat;
  final int quality; // 1-100 for lossy formats

  ConversionSettings({required this.targetFormat, this.quality = 90});

  ConversionSettings copyWith({ImageFormat? targetFormat, int? quality}) {
    return ConversionSettings(
      targetFormat: targetFormat ?? this.targetFormat,
      quality: quality ?? this.quality,
    );
  }
}
