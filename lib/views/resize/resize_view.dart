import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/di/service_locator.dart';
import 'package:flutter_image_converters/core/utils/toast_helper.dart';
import 'package:flutter_image_converters/core/widgets/pick_image_button_widget.dart';
import 'package:flutter_image_converters/services/dialog_service.dart';
import 'package:flutter_image_converters/views/resize/widgets/reset_result_card.dart';
import 'package:flutter_image_converters/views/resize/widgets/reset_setting_card.dart';
import 'package:flutter_image_converters/views/resize/widgets/reset_source_image_card.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/resize_viewmodel.dart';
import '../../core/widgets/widgets.dart';

class ResizeView extends StatelessWidget {
  const ResizeView({super.key});

  @override
  Widget build(BuildContext context) {
    final dialogService = getIt<DialogService>();

    return Consumer<ResizeViewModel>(
      builder: (context, viewModel, child) {
        // Show error toast
        if (viewModel.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ToastHelper.showError(
              context,
              'Error Occurred',
              subtitle: viewModel.errorMessage,
            );
            viewModel.clearError();
          });
        }

        // Show loading indicator
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ToastHelper.showError(
              context,
              'Error Occurred',
              subtitle: viewModel.errorMessage,
            );
            viewModel.clearError();
          });
        }

        // Show centered empty state when no image
        if (!viewModel.hasSourceImage && !viewModel.hasResizedImage) {
          return PickImageButtonWidget(
            title: 'Resize Your Images',
            subtitle: 'Select an image to get started',
            onPressed: viewModel.pickImage,
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Source Image Section
              ResetSourceImageCard(
                sourceImage: viewModel.sourceImage,
                clear: viewModel.clear,
              ),

              // Settings Section
              ResetSettingCard(
                maintainAspectRatio: viewModel.settings.maintainAspectRatio,
                toggleAspectRatio: viewModel.toggleAspectRatio,
                widthController: viewModel.widthController,
                heightController: viewModel.heightController,
                sourceImage: viewModel.sourceImage,
              ),

              // Resize Button
              if (viewModel.canResize)
                GradientButton(
                  onPressed: () => dialogService.showResizeAdDialog(
                    context,
                    onContinue: viewModel.resizeImage,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_size_select_large, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Resize Image'),
                    ],
                  ),
                ),

              // Result Section
              if (viewModel.hasResizedImage) ...[
                const SizedBox(height: 24),
                ResetResultCard(
                  errorMessage: viewModel.errorMessage ?? '',
                  shouldShowSaveButton: viewModel.shouldShowSaveButton,
                  saveResizedImage: () {
                    return viewModel.onSaveResizedImage(context);
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
