/// Supported image formats for conversion
enum ImageFormat {
  jpg('JPG', 'jpg'),
  png('PNG', 'png'),
  webp('WebP', 'webp'),
  bmp('BMP', 'bmp');

  final String displayName;
  final String extension;

  const ImageFormat(this.displayName, this.extension);
}

/// Settings for image conversion
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

/// Settings for image resize
class ResizeSettings {
  final int? width;
  final int? height;
  final bool maintainAspectRatio;

  ResizeSettings({this.width, this.height, this.maintainAspectRatio = true});

  ResizeSettings copyWith({
    int? width,
    int? height,
    bool? maintainAspectRatio,
  }) {
    return ResizeSettings(
      width: width ?? this.width,
      height: height ?? this.height,
      maintainAspectRatio: maintainAspectRatio ?? this.maintainAspectRatio,
    );
  }

  bool get isValid => width != null || height != null;
}
