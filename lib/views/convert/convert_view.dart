import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/conversion_settings.dart';
import '../../viewmodels/conversion_viewmodel.dart';

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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(viewModel.errorMessage!),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: Colors.white,
                  onPressed: () => viewModel.clearError(),
                ),
              ),
            );
            viewModel.clearError();
          });
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Source Images Section
              if (!viewModel.hasSourceImages)
                _buildPickImageButton(context, viewModel)
              else
                _buildSourceImagesSection(context, viewModel),

              const SizedBox(height: 16),

              // Settings Section
              if (viewModel.hasSourceImages) ...[
                _buildSettingsCard(context, viewModel),
                const SizedBox(height: 16),
              ],

              // Convert Button
              if (viewModel.hasSourceImages)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: viewModel.isLoading
                        ? null
                        : viewModel.convertImages,
                    icon: viewModel.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.transform),
                    label: Text(
                      viewModel.isLoading
                          ? 'Converting ${viewModel.convertedCount}/${viewModel.totalCount}...'
                          : 'Convert ${viewModel.sourceImages.length} Image(s)',
                    ),
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

  Widget _buildPickImageButton(
    BuildContext context,
    ConversionViewModel viewModel,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Icon(
            Icons.image_outlined,
            size: 100,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: viewModel.pickImages,
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('Select Images'),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceImagesSection(
    BuildContext context,
    ConversionViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Source Images (${viewModel.sourceImages.length})',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: viewModel.pickImages,
                      tooltip: 'Add more images',
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear_all),
                      onPressed: viewModel.clear,
                      tooltip: 'Clear all',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.sourceImages.length,
                itemBuilder: (context, index) {
                  final image = viewModel.sourceImages[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: image.bytes != null
                              ? Image.memory(
                                  image.bytes!,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.grey,
                                ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 16,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  viewModel.removeSourceImage(index),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              image.dimensionsDisplay,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context,
    ConversionViewModel viewModel,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: ImageFormat.values.map((format) {
                  final isSelected = viewModel.settings.targetFormat == format;
                  return ChoiceChip(
                    label: Text(format.displayName),
                    selected: isSelected,
                    onSelected: (_) => viewModel.updateTargetFormat(format),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              // Quality Slider (for lossy formats)
              if (viewModel.settings.targetFormat == ImageFormat.jpg ||
                  viewModel.settings.targetFormat == ImageFormat.webp) ...[
                Text(
                  'Quality: ${viewModel.settings.quality}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Slider(
                  value: viewModel.settings.quality.toDouble(),
                  min: 1,
                  max: 100,
                  divisions: 99,
                  label: '${viewModel.settings.quality}%',
                  onChanged: (value) => viewModel.updateQuality(value.toInt()),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsSection(
    BuildContext context,
    ConversionViewModel viewModel,
  ) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Conversion Complete! (${viewModel.convertedImages.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.convertedImages.length,
                itemBuilder: (context, index) {
                  final image = viewModel.convertedImages[index];
                  final sourceImage = viewModel.sourceImages[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: image.bytes != null
                              ? Image.memory(
                                  image.bytes!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 120,
                                  width: 120,
                                  color: Colors.grey,
                                ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sourceImage.sizeDisplay,
                                style: const TextStyle(fontSize: 11),
                              ),
                              const Icon(Icons.arrow_downward, size: 14),
                              Text(
                                image.sizeDisplay,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement save functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Save functionality coming soon!'),
                    ),
                  );
                },
                icon: const Icon(Icons.save),
                label: Text(
                  'Save ${viewModel.convertedImages.length} Image(s)',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
