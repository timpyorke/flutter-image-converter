import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/resize_viewmodel.dart';

class ResizeView extends StatefulWidget {
  const ResizeView({super.key});

  @override
  State<ResizeView> createState() => _ResizeViewState();
}

class _ResizeViewState extends State<ResizeView> {
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Source Image Section
              if (!viewModel.hasSourceImage)
                _buildPickImageButton(context, viewModel)
              else
                _buildSourceImageCard(context, viewModel),

              const SizedBox(height: 16),

              // Settings Section
              if (viewModel.hasSourceImage) ...[
                _buildSettingsCard(context, viewModel),
                const SizedBox(height: 16),
              ],

              // Resize Button
              if (viewModel.hasSourceImage && viewModel.canResize)
                FilledButton.icon(
                  onPressed: viewModel.resizeImage,
                  icon: const Icon(Icons.photo_size_select_large),
                  label: const Text('Resize Image'),
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

  Widget _buildPickImageButton(
    BuildContext context,
    ResizeViewModel viewModel,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Icon(
            Icons.photo_size_select_large_outlined,
            size: 100,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: viewModel.pickImage,
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('Select Image to Resize'),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceImageCard(
    BuildContext context,
    ResizeViewModel viewModel,
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
                  'Source Image',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    viewModel.clear();
                    _widthController.clear();
                    _heightController.clear();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (viewModel.sourceImage!.bytes != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  viewModel.sourceImage!.bytes!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            _buildImageInfo(context, viewModel.sourceImage!),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, ResizeViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resize Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),

            // Aspect Ratio Lock
            CheckboxListTile(
              title: const Text('Maintain Aspect Ratio'),
              value: viewModel.settings.maintainAspectRatio,
              onChanged: (_) => viewModel.toggleAspectRatio(),
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: 16),

            // Dimensions Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _widthController,
                    decoration: const InputDecoration(
                      labelText: 'Width',
                      border: OutlineInputBorder(),
                      suffixText: 'px',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final width = int.tryParse(value);
                      viewModel.updateWidth(width);

                      if (viewModel.settings.maintainAspectRatio &&
                          width != null &&
                          viewModel.sourceImage != null) {
                        final sourceWidth = viewModel.sourceImage!.width ?? 1;
                        final sourceHeight = viewModel.sourceImage!.height ?? 1;
                        final newHeight = (sourceHeight * width / sourceWidth)
                            .round();
                        _heightController.text = newHeight.toString();
                        viewModel.updateHeight(newHeight);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    decoration: const InputDecoration(
                      labelText: 'Height',
                      border: OutlineInputBorder(),
                      suffixText: 'px',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final height = int.tryParse(value);
                      viewModel.updateHeight(height);

                      if (viewModel.settings.maintainAspectRatio &&
                          height != null &&
                          viewModel.sourceImage != null) {
                        final sourceWidth = viewModel.sourceImage!.width ?? 1;
                        final sourceHeight = viewModel.sourceImage!.height ?? 1;
                        final newWidth = (sourceWidth * height / sourceHeight)
                            .round();
                        _widthController.text = newWidth.toString();
                        viewModel.updateWidth(newWidth);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, ResizeViewModel viewModel) {
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
                  'Resize Complete!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (viewModel.resizedImage!.bytes != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  viewModel.resizedImage!.bytes!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            _buildImageInfo(context, viewModel.resizedImage!),
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
                label: const Text('Save Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageInfo(BuildContext context, dynamic imageData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow('Name', imageData.name ?? 'Unknown'),
        _infoRow('Dimensions', imageData.dimensionsDisplay),
        _infoRow('Format', imageData.format?.toUpperCase() ?? 'Unknown'),
        _infoRow('Size', imageData.sizeDisplay),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}
