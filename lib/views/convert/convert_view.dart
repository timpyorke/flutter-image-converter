import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/image_format.dart';
import 'package:flutter_image_converters/core/di/service_locator.dart';
import 'package:flutter_image_converters/core/utils/toast_helper.dart';
import 'package:flutter_image_converters/core/widgets/pick_image_button_widget.dart';
import 'package:flutter_image_converters/services/dialog_service.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/conversion_viewmodel.dart';
import '../../core/widgets/widgets.dart';

class ConvertView extends StatefulWidget {
  const ConvertView({super.key});

  @override
  State<ConvertView> createState() => _ConvertViewState();
}

class _ConvertViewState extends State<ConvertView> {
  final DialogService _dialogService = getIt<DialogService>();
  bool _previousHasSavedImages = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversionViewModel>(
      builder: (context, viewModel, child) {
        // Show auto-save success toast
        if (viewModel.hasSavedImages &&
            !_previousHasSavedImages &&
            viewModel.shouldAutoSave) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_previousHasSavedImages && viewModel.hasSavedImages) {
              final count = viewModel.savedPaths.length;
              ToastHelper.showSuccess(
                context,
                'Automatically Saved!',
                subtitle:
                    '$count image${count > 1 ? 's' : ''} saved to gallery',
              );
              setState(() {
                _previousHasSavedImages = true;
              });
            }
          });
        } else if (!viewModel.hasSavedImages) {
          _previousHasSavedImages = false;
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

        // Show centered empty state when no images
        if (!viewModel.hasSourceImages && !viewModel.hasConvertedImages) {
          return PickImageButtonWidget(
            title: 'Select Images to Convert',
            subtitle: 'Choose multiple images from your gallery',
            onPressed: viewModel.pickImages,
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Source Images Section
              _buildSourceImagesSection(context, viewModel),

              const SizedBox(height: 16),

              // Settings Section
              _buildSettingsCard(context, viewModel),
              const SizedBox(height: 20),

              // Convert Button
              GradientButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () => _dialogService.showConvertAdDialog(
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
                const SizedBox(height: 24),
                _buildResultsSection(context, viewModel),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceImagesSection(
    BuildContext context,
    ConversionViewModel viewModel,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
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
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Source Images',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${viewModel.sourceImages.length} selected',
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
                      icon: const Icon(Icons.add_rounded, size: 20),
                      onPressed: viewModel.pickImages,
                      tooltip: 'Add more',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GlassContainer(
                    padding: const EdgeInsets.all(8),
                    borderRadius: 12,
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, size: 20),
                      onPressed: viewModel.clear,
                      tooltip: 'Clear all',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 4),
              itemCount: viewModel.sourceImages.length,
              itemBuilder: (context, index) {
                final image = viewModel.sourceImages[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GlassContainer(
                    padding: EdgeInsets.zero,
                    borderRadius: 20,
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
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    padding: const EdgeInsets.all(8),
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: () =>
                                        viewModel.removeSourceImage(index),
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
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(12),
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

  Widget _buildSettingsCard(
    BuildContext context,
    ConversionViewModel viewModel,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Target Format',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ImageFormat.values.map((format) {
              final isSelected = viewModel.settings.targetFormat == format;
              return GestureDetector(
                onTap: () => viewModel.updateTargetFormat(format),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          )
                        : null,
                    color: isSelected
                        ? null
                        : Theme.of(
                            context,
                          ).colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    format.displayName,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (viewModel.settings.targetFormat == ImageFormat.jpg ||
              viewModel.settings.targetFormat == ImageFormat.webp) ...[
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quality',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.2),
                        Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${viewModel.settings.quality}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                _buildQualityChip(context, viewModel, 'Low', 50),
                _buildQualityChip(context, viewModel, 'Medium', 75),
                _buildQualityChip(context, viewModel, 'High', 90),
                _buildQualityChip(context, viewModel, 'Max', 100),
              ],
            ),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 6,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                activeTrackColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                thumbColor: Theme.of(context).colorScheme.primary,
                overlayColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.2),
              ),
              child: Slider(
                value: viewModel.settings.quality.toDouble(),
                min: 1,
                max: 100,
                divisions: 99,
                label: '${viewModel.settings.quality}%',
                onChanged: (value) => viewModel.updateQuality(value.toInt()),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultsSection(
    BuildContext context,
    ConversionViewModel viewModel,
  ) {
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
                      'Conversion Complete!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${viewModel.convertedImages.length} image${viewModel.convertedImages.length > 1 ? "s" : ""} converted successfully',
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
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 4),
              itemCount: viewModel.convertedImages.length,
              itemBuilder: (context, index) {
                final image = viewModel.convertedImages[index];
                final sourceImage = viewModel.sourceImages[index];
                final sizeDiff = sourceImage.sizeInBytes! - image.sizeInBytes!;
                final percentReduced =
                    (sizeDiff / sourceImage.sizeInBytes! * 100).round();

                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(12),
                    borderRadius: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedImageThumbnail(
                          imageData: image,
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                          thumbnailSize: 200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        const SizedBox(height: 12),
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
                                    'Before',
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
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'After',
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
                                      const SizedBox(width: 4),
                                      if (percentReduced > 0)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius: BorderRadius.circular(
                                              4,
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
          const SizedBox(height: 20),
          GradientButton(
            onPressed: () async {
              await viewModel.convertAndSaveImages();
              if (context.mounted) {
                if (viewModel.hasSavedImages) {
                  final count = viewModel.savedPaths.length;
                  ToastHelper.showSuccess(
                    context,
                    'Successfully Saved!',
                    subtitle:
                        '$count image${count > 1 ? "s" : ""} saved to gallery',
                  );
                } else {
                  ToastHelper.showError(
                    context,
                    'Failed to Save',
                    subtitle: viewModel.errorMessage ?? 'Could not save images',
                  );
                }
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.download_rounded, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  'Save ${viewModel.convertedImages.length} Image${viewModel.convertedImages.length > 1 ? "s" : ""}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityChip(
    BuildContext context,
    ConversionViewModel viewModel,
    String label,
    int quality,
  ) {
    final isSelected = viewModel.settings.quality == quality;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        viewModel.updateQuality(quality);
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
