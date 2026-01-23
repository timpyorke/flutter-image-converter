import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/app_dimensions.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';
import 'package:flutter_image_converters/core/widgets/cached_image_thumbnail.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/core/widgets/glass_container.dart';
import 'package:flutter_image_converters/models/image_data.dart';

class SourceImagesSection extends StatelessWidget {
  const SourceImagesSection({
    super.key,
    required this.imageCount,
    required this.pickImages,
    required this.clear,
    required this.sourceImages,
    required this.removeSourceImage,
  });

  final List<ImageData> sourceImages;
  final int imageCount;
  final VoidCallback pickImages;
  final VoidCallback clear;
  final Function(int) removeSourceImage;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppDimensions.paddingXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.photo_library_rounded,
                      color: Colors.white,
                      size: AppDimensions.iconS,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingM),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.sourceImages,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '$imageCount ${context.l10n.selected}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  GlassContainer(
                    padding: const EdgeInsets.all(8),
                    borderRadius: 12,
                    child: IconButton(
                      icon: const Icon(Icons.add_rounded,
                          size: AppDimensions.iconS),
                      onPressed: pickImages,
                      tooltip: context.l10n.addMore,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingS),
                  GlassContainer(
                    padding: const EdgeInsets.all(8),
                    borderRadius: 12,
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded,
                          size: AppDimensions.iconS),
                      onPressed: clear,
                      tooltip: context.l10n.clearAll,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingXl),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 4),
              itemCount: imageCount,
              itemBuilder: (context, index) {
                final image = sourceImages[index];
                return Padding(
                  padding: const EdgeInsets.only(right: AppDimensions.paddingM),
                  child: GlassContainer(
                    padding: EdgeInsets.zero,
                    borderRadius: AppDimensions.radiusXl,
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          CachedImageThumbnail(
                            imageData: image,
                            height: 160,
                            width: 140,
                            fit: BoxFit.cover,
                            thumbnailSize: 200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusXl),
                                  ),
                                  child: IconButton(
                                    padding: const EdgeInsets.all(
                                        AppDimensions.paddingS),
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: () => removeSourceImage(index),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 8,
                            right: 8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.paddingS,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusM),
                                  ),
                                  child: Text(
                                    image.dimensionsDisplay,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
