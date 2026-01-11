enum ImageFormat {
  jpg('JPG', 'jpg'),
  png('PNG', 'png'),
  webp('WebP', 'webp'),
  bmp('BMP', 'bmp');

  final String displayName;
  final String extension;

  const ImageFormat(this.displayName, this.extension);
}
