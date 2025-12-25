import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/widgets/cached_image_thumbnail.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/core/widgets/glass_container.dart';
import 'package:flutter_image_converters/models/image_data.dart';
import 'package:flutter_image_converters/views/resize/widgets/reset_image_info.dart';

class ResetSourceImageCard extends StatelessWidget {
  const ResetSourceImageCard({
    super.key,
    required this.sourceImage,
    required this.clear,
  });

  final ImageData? sourceImage;
  final VoidCallback clear;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Source Image',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              GlassContainer(
                padding: const EdgeInsets.all(8),
                borderRadius: 12,
                child: InkWell(
                  onTap: clear,
                  child: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (sourceImage!.bytes != null)
            CachedImageThumbnail(
              imageData: sourceImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              thumbnailSize: 300,
              borderRadius: BorderRadius.circular(16),
            ),
          const SizedBox(height: 16),
          ResetImageInfo(imageData: sourceImage!),
        ],
      ),
    );
  }
}
