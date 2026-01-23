import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/const/app_dimensions.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/core/widgets/glass_container.dart';
import 'package:flutter_image_converters/core/widgets/gradient_button.dart';
import 'package:flutter_image_converters/presentation/models/image_data.dart';

class ConvertResultSection extends StatelessWidget {
  const ConvertResultSection({
    super.key,
    required this.quality,
    required this.savedPaths,
    required this.hasSavedImages,
    required this.convertAndSaveImages,
    required this.convertedImages,
    required this.sourceImages,
    this.shouldShowSaveButton = true,
  });

  final int quality;
  final int savedPaths;
  final bool hasSavedImages;
  final List<ImageData> convertedImages;
  final List<ImageData> sourceImages;
  final VoidCallback convertAndSaveImages;
  final bool shouldShowSaveButton;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppDimensions.paddingXxl),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        spacing: AppDimensions.spacingM,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade600],
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.3),
                      blurRadius: AppDimensions.blurMedium,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: AppDimensions.iconL,
                ),
              ),
              const SizedBox(width: AppDimensions.spacingL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.conversionComplete,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      '$quality image${quality > 1 ? "s" : ""} converted successfully',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 4),
              itemCount: quality,
              itemBuilder: (context, index) {
                final image = convertedImages[index];
                final sourceImage = sourceImages[index];
                final sizeDiff = sourceImage.sizeInBytes! - image.sizeInBytes!;
                final percentReduced =
                    (sizeDiff / sourceImage.sizeInBytes! * 100).round();

                return Padding(
                  padding: const EdgeInsets.only(right: AppDimensions.paddingL),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    borderRadius: AppDimensions.radiusXl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusL),
                          child: image.bytes != null
                              ? Image.memory(
                                  image.bytes!,
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 140,
                                  width: 140,
                                  color: Colors.grey.shade300,
                                ),
                        ),
                        const SizedBox(height: AppDimensions.spacingM),
                        SizedBox(
                          width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.l10n.before,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                  Text(
                                    sourceImage.sizeDisplay,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDimensions.spacingXs),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.l10n.after,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        image.sizeDisplay,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green.shade600,
                                        ),
                                      ),
                                      const SizedBox(
                                          width: AppDimensions.spacingXs),
                                      if (percentReduced > 0)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppDimensions.paddingXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius: BorderRadius.circular(
                                              AppDimensions.radiusXs,
                                            ),
                                          ),
                                          child: Text(
                                            '-$percentReduced%',
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green.shade700,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (shouldShowSaveButton)
            GradientButton(
              onPressed: convertAndSaveImages,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.download_rounded, color: Colors.white),
                  const SizedBox(width: AppDimensions.spacingM),
                  Text('Save $quality Image${quality > 1 ? "s" : ""}'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
