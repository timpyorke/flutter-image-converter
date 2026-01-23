import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/app_dimensions.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';

/// Overlay widget to show processing progress
class ProcessingOverlay extends StatelessWidget {
  const ProcessingOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(AppDimensions.paddingXxl),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingXxl),
            child: Column(
              spacing: AppDimensions.spacingM,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Loading indicator
                const CircularProgressIndicator(
                  strokeWidth: 6,
                  backgroundColor: Colors.grey,
                ),

                // Message
                Text(
                  context.l10n.pleaseWait,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
