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
