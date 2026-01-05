import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/app_dimensions.dart';
import 'package:flutter_image_converters/const/app_strings.dart';

/// Overlay widget to show processing progress
class ProcessingOverlay extends StatelessWidget {
  final int current;
  final int total;
  final String? message;

  const ProcessingOverlay({
    super.key,
    required this.current,
    required this.total,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? current / total : 0.0;
    final percentage = (progress * 100).round();

    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(AppDimensions.paddingXxl),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingXxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Loading indicator
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 6,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '$percentage%',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingXl),

                // Message
                Text(
                  message ?? context.l10n.processingNImages(current, total),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.spacingS),

                // Please wait text
                Text(
                  context.l10n.pleaseWait,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
