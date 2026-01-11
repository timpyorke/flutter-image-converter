import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/widgets/cached_image_thumbnail.dart';
import 'package:flutter_image_converters/core/widgets/glass_card.dart';
import 'package:flutter_image_converters/core/widgets/gradient_button.dart';
import 'package:flutter_image_converters/models/image_data.dart';
import 'package:flutter_image_converters/views/resize/widgets/reset_image_info.dart';
import 'package:flutter_image_converters/l10n/l10n.dart'; // Needed for BuildContext extension if not global

class ResetResultCard extends StatelessWidget {
  const ResetResultCard({
    super.key,
    required this.errorMessage,
    required this.shouldShowSaveButton,
    required this.saveResizedImage,
    this.resizedImage,
  });

  final String errorMessage;
  final bool shouldShowSaveButton;
  final ImageData? resizedImage;
  final VoidCallback saveResizedImage;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade600],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.resizeComplete,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      context.l10n.imageResizedSuccessfully,
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
          const SizedBox(height: 20),
          if (resizedImage?.bytes != null)
            CachedImageThumbnail(
              imageData: resizedImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              thumbnailSize: 300,
              borderRadius: BorderRadius.circular(16),
            ),
          const SizedBox(height: 20),
          ResetImageInfo(imageData: resizedImage),
          const SizedBox(height: 20),
          if (shouldShowSaveButton)
            GradientButton(
              onPressed: saveResizedImage,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.download_rounded, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(context.l10n.save),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
