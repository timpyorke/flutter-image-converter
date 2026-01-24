import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/const/app_dimensions.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';
import 'package:flutter_image_converters/core/widgets/cached_image_thumbnail.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/core/widgets/glass_container.dart';
import 'package:flutter_image_converters/domain/models/image_data.dart';

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
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 4),
              itemCount: imageCount,
              itemBuilder: (context, index) {
                final image = sourceImages[index];
                return Padding(
                  padding: const EdgeInsets.only(right: AppDimensions.paddingM),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(AppDimensions.paddingS),
                    borderRadius: AppDimensions.radiusXl,
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CachedImageThumbnail(
                                imageData: image,
                                height: 140,
                                width: 140,
                                fit: BoxFit.cover,
                                thumbnailSize: 300,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.black.withValues(alpha: 0.3),
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.radiusXl),
                                      ),
                                      child: IconButton(
                                        padding: const EdgeInsets.all(4),
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        onPressed: () =>
                                            removeSourceImage(index),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  image.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${image.dimensionsDisplay} • ${image.sizeDisplay}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.6),
                                      ),
                                ),
                              ],
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
