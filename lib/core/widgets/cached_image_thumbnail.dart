import 'package:flutter/material.dart';
import '../../presentation/models/image_data.dart';
import '../services/image_service.dart';
import '../../core/di/service_locator.dart';

/// Optimized image thumbnail widget with caching
class CachedImageThumbnail extends StatefulWidget {
  final ImageData imageData;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int thumbnailSize;
  final BorderRadius? borderRadius;

  const CachedImageThumbnail({
    super.key,
    required this.imageData,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.thumbnailSize = 200,
    this.borderRadius,
  });

  @override
  State<CachedImageThumbnail> createState() => _CachedImageThumbnailState();
}

class _CachedImageThumbnailState extends State<CachedImageThumbnail>
    with AutomaticKeepAliveClientMixin {
  final ImageService _imageService = getIt<ImageService>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return FutureBuilder<Image>(
      future: _loadThumbnail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          Widget imageWidget = snapshot.data!;

          if (widget.borderRadius != null) {
            imageWidget = ClipRRect(
              borderRadius: widget.borderRadius!,
              child: imageWidget,
            );
          }

          return imageWidget;
        }

        // Show placeholder while loading
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: widget.borderRadius,
          ),
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );
  }

  Future<Image> _loadThumbnail() async {
    final thumbnailBytes = await _imageService.getThumbnail(
      widget.imageData,
      maxSize: widget.thumbnailSize,
    );

    return Image.memory(
      thumbnailBytes,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      gaplessPlayback: true,
      // Prevent image from being disposed when scrolled out of view
      cacheWidth: widget.thumbnailSize,
    );
  }
}
