import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/const/app_dimensions.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';
import 'package:flutter_image_converters/core/utils/toast_helper.dart';
import 'package:flutter_image_converters/core/widgets/pick_image_button_widget.dart';
import 'package:flutter_image_converters/presentation/views/convert/widgets/Source_images_section.dart';
import 'package:flutter_image_converters/presentation/views/convert/widgets/convert_settings_card.dart';
import 'package:flutter_image_converters/presentation/views/convert/widgets/convert_result_section.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/conversion_viewmodel.dart';
import '../../../core/widgets/widgets.dart';

class ConvertView extends StatelessWidget {
  const ConvertView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversionViewModel>(
      builder: (context, viewModel, child) {
        // Show error toast
        if (viewModel.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ToastHelper.showError(
              context,
              context.l10n.errorOccurred,
              subtitle: viewModel.errorMessage,
            );
            viewModel.clearError();
          });
        }

        // Build main content
        Widget mainContent;

        if (!viewModel.hasSourceImages && !viewModel.hasConvertedImages) {
          // Empty state
          mainContent = PickImageButtonWidget(
            title: context.l10n.convertYourImages,
            subtitle: context.l10n.selectImagesToGetStarted,
            onPressed: viewModel.pickImages,
          );
        } else {
          // Main content with images
          mainContent = SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.paddingL,
              AppDimensions.paddingL,
              AppDimensions.paddingL,
              AppDimensions.bottomPaddingWithNav,
            ),
            child: Column(
              spacing: AppDimensions.spacingM,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Source Images Section
                SourceImagesSection(
                  imageCount: viewModel.sourceImages.length,
                  pickImages: viewModel.pickImages,
                  clear: viewModel.clear,
                  sourceImages: viewModel.sourceImages,
                  removeSourceImage: viewModel.removeSourceImage,
                ),

                // Settings Section
                ConvertSettingsCard(
                  quality: viewModel.settings.quality,
                  targetFormat: viewModel.settings.targetFormat,
                  updateTargetFormat: viewModel.updateTargetFormat,
                  updateQuality: viewModel.updateQuality,
                ),

                // Convert Button
                GradientButton(
                  onPressed: viewModel.isLoading
                      ? null
                      : () => viewModel.onShowConvertAdDialog(
                            context,
                            imageCount: viewModel.sourceImages.length,
                            onContinue: viewModel.convertImages,
                          ),
                  height: 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_fix_high_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Convert ${viewModel.sourceImages.length} Image${viewModel.sourceImages.length > 1 ? "s" : ""}',
                      ),
                    ],
                  ),
                ),

                // Result Section
                if (viewModel.hasConvertedImages) ...[
                  ConvertResultSection(
                    quality: viewModel.convertedImages.length,
                    savedPaths: viewModel.savedPaths.length,
                    hasSavedImages: viewModel.hasSavedImages,
                    convertAndSaveImages: () =>
                        viewModel.onConvertAndSaveImages(context),
                    convertedImages: viewModel.convertedImages,
                    sourceImages: viewModel.sourceImages,
                    shouldShowSaveButton: viewModel.shouldShowSaveButton,
                  ),
                ],
              ],
            ),
          );
        }

        // Wrap with processing overlay when loading
        return Stack(
          children: [
            mainContent,
            if (viewModel.isLoading) ProcessingOverlay(),
          ],
        );
      },
    );
  }
}
