import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/app_dimensions.dart';
import 'package:flutter_image_converters/const/app_strings.dart';
import 'package:flutter_image_converters/core/utils/toast_helper.dart';
import 'package:flutter_image_converters/core/widgets/pick_image_button_widget.dart';
import 'package:flutter_image_converters/views/convert/widgets/Source_images_section.dart';
import 'package:flutter_image_converters/views/convert/widgets/convert_settings_card.dart';
import 'package:flutter_image_converters/views/convert/widgets/result_section.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/conversion_viewmodel.dart';
import '../../core/widgets/widgets.dart';

class ConvertView extends StatelessWidget {
  const ConvertView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversionViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

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

        // Show centered empty state when no images
        if (!viewModel.hasSourceImages && !viewModel.hasConvertedImages) {
          return PickImageButtonWidget(
            title: context.l10n.convertYourImages,
            subtitle: context.l10n.selectImagesToGetStarted,
            onPressed: viewModel.pickImages,
          );
        }

        return SingleChildScrollView(
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
                child: viewModel.isLoading
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Converting ${viewModel.convertedCount}/${viewModel.totalCount}...',
                          ),
                        ],
                      )
                    : Row(
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
                ResultSection(
                  quality: viewModel.settings.quality,
                  targetFormat: viewModel.settings.targetFormat,
                  updateTargetFormat: (format) {
                    viewModel.updateTargetFormat(format);
                  },
                  updateQuality: (qulity) {
                    viewModel.updateQuality(qulity);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
