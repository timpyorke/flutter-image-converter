import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/di/service_locator.dart';
import 'package:flutter_image_converters/core/utils/toast_helper.dart';
import 'package:flutter_image_converters/core/widgets/pick_image_button_widget.dart';
import 'package:flutter_image_converters/services/dialog_service.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/resize_viewmodel.dart';
import '../../core/widgets/widgets.dart';

class ResizeView extends StatefulWidget {
  const ResizeView({super.key});

  @override
  State<ResizeView> createState() => _ResizeViewState();
}

class _ResizeViewState extends State<ResizeView> {
  final DialogService _dialogService = getIt<DialogService>();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  bool _previousHasResizedImage = false;

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ResizeViewModel>(
      builder: (context, viewModel, child) {
        // Show auto-save success toast
        if (viewModel.hasResizedImage &&
            !_previousHasResizedImage &&
            viewModel.shouldAutoSave &&
            viewModel.errorMessage == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_previousHasResizedImage && viewModel.hasResizedImage) {
              ToastHelper.showSuccess(
                context,
                'Image Saved!',
                subtitle: 'Your resized image has been automatically saved',
              );
              setState(() {
                _previousHasResizedImage = true;
              });
            }
          });
        } else if (!viewModel.hasResizedImage) {
          _previousHasResizedImage = false;
        }

        // Update controllers when source image changes
        if (viewModel.hasSourceImage && _widthController.text.isEmpty) {
          _widthController.text =
              viewModel.sourceImage!.width?.toString() ?? '';
          _heightController.text =
              viewModel.sourceImage!.height?.toString() ?? '';
        }

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Source Image Section
              _buildSourceImageCard(context, viewModel),

              const SizedBox(height: 16),

              // Settings Section
              _buildSettingsCard(context, viewModel),
              const SizedBox(height: 16),

              // Resize Button
              if (viewModel.canResize)
                GradientButton(
                  onPressed: () => _dialogService.showResizeAdDialog(
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
                _buildResultCard(context, viewModel),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceImageCard(
    BuildContext context,
    ResizeViewModel viewModel,
  ) {
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
                  onTap: () {
                    viewModel.clear();
                    _widthController.clear();
                    _heightController.clear();
                  },
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
          if (viewModel.sourceImage!.bytes != null)
            CachedImageThumbnail(
              imageData: viewModel.sourceImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              thumbnailSize: 300,
              borderRadius: BorderRadius.circular(16),
            ),
          const SizedBox(height: 16),
          _buildImageInfo(context, viewModel.sourceImage!),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, ResizeViewModel viewModel) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resize Settings',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),

          // Aspect Ratio Lock
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            borderRadius: 16,
            child: CheckboxListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.aspect_ratio_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  const Text('Maintain Aspect Ratio'),
                ],
              ),
              value: viewModel.settings.maintainAspectRatio,
              onChanged: (_) => viewModel.toggleAspectRatio(),
              contentPadding: EdgeInsets.zero,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 20),

          // Quick Resize Options
          Text(
            'Reduce by %',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildPercentageChip(context, viewModel, 25),
              _buildPercentageChip(context, viewModel, 50),
              _buildPercentageChip(context, viewModel, 75),
              _buildResetChip(context, viewModel),
            ],
          ),

          const SizedBox(height: 20),

          // Dimensions Input
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Width',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _widthController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        suffixText: 'px',
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.5),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final width = int.tryParse(value);
                        viewModel.updateWidth(width);

                        if (viewModel.settings.maintainAspectRatio &&
                            width != null &&
                            viewModel.sourceImage != null) {
                          final sourceWidth = viewModel.sourceImage!.width ?? 1;
                          final sourceHeight =
                              viewModel.sourceImage!.height ?? 1;
                          final newHeight = (sourceHeight * width / sourceWidth)
                              .round();
                          _heightController.text = newHeight.toString();
                          viewModel.updateHeight(newHeight);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Height',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        suffixText: 'px',
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.5),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final height = int.tryParse(value);
                        viewModel.updateHeight(height);

                        if (viewModel.settings.maintainAspectRatio &&
                            height != null &&
                            viewModel.sourceImage != null) {
                          final sourceWidth = viewModel.sourceImage!.width ?? 1;
                          final sourceHeight =
                              viewModel.sourceImage!.height ?? 1;
                          final newWidth = (sourceWidth * height / sourceHeight)
                              .round();
                          _widthController.text = newWidth.toString();
                          viewModel.updateWidth(newWidth);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, ResizeViewModel viewModel) {
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
                      'Resize Complete!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Your image has been resized successfully',
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
          if (viewModel.resizedImage!.bytes != null)
            CachedImageThumbnail(
              imageData: viewModel.resizedImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              thumbnailSize: 300,
              borderRadius: BorderRadius.circular(16),
            ),
          const SizedBox(height: 20),
          _buildImageInfo(context, viewModel.resizedImage!),
          const SizedBox(height: 20),
          GradientButton(
            onPressed: () async {
              final success = await viewModel.saveResizedImage();
              if (context.mounted) {
                if (success) {
                  ToastHelper.showSuccess(
                    context,
                    'Image Saved!',
                    subtitle: 'Your resized image has been saved to gallery',
                  );
                } else {
                  ToastHelper.showError(
                    context,
                    'Save Failed',
                    subtitle: viewModel.errorMessage ?? 'Could not save image',
                  );
                }
              }
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download_rounded, color: Colors.white),
                SizedBox(width: 12),
                Text('Save Image'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageInfo(BuildContext context, dynamic imageData) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(context, 'Name', imageData.name ?? 'Unknown'),
          const SizedBox(height: 8),
          _infoRow(context, 'Dimensions', imageData.dimensionsDisplay),
          const SizedBox(height: 8),
          _infoRow(
            context,
            'Format',
            imageData.format?.toUpperCase() ?? 'Unknown',
          ),
          const SizedBox(height: 8),
          _infoRow(context, 'Size', imageData.sizeDisplay),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildPercentageChip(
    BuildContext context,
    ResizeViewModel viewModel,
    int percentage,
  ) {
    return FilterChip(
      label: Text('$percentage%'),
      selected: false,
      onSelected: (_) {
        if (viewModel.sourceImage != null) {
          final sourceWidth = viewModel.sourceImage!.width ?? 0;
          final sourceHeight = viewModel.sourceImage!.height ?? 0;

          final newWidth = (sourceWidth * (100 - percentage) / 100).round();
          final newHeight = (sourceHeight * (100 - percentage) / 100).round();

          _widthController.text = newWidth.toString();
          _heightController.text = newHeight.toString();

          viewModel.updateWidth(newWidth);
          viewModel.updateHeight(newHeight);
        }
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildResetChip(BuildContext context, ResizeViewModel viewModel) {
    return FilterChip(
      label: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.refresh_rounded, size: 16),
          SizedBox(width: 4),
          Text('Reset'),
        ],
      ),
      selected: false,
      onSelected: (_) {
        if (viewModel.sourceImage != null) {
          final sourceWidth = viewModel.sourceImage!.width ?? 0;
          final sourceHeight = viewModel.sourceImage!.height ?? 0;

          _widthController.text = sourceWidth.toString();
          _heightController.text = sourceHeight.toString();

          viewModel.updateWidth(sourceWidth);
          viewModel.updateHeight(sourceHeight);
        }
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(
        context,
      ).colorScheme.secondary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
