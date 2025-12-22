import 'package:flutter/material.dart';
import '../../core/widgets/glass_widgets.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy Policy',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Last updated: December 21, 2025',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    context,
                    'Information We Collect',
                    'Image Converter is designed with your privacy in mind. We do not collect, store, or transmit any personal information or data from your device.',
                  ),
                  _buildSection(
                    context,
                    'How We Use Your Information',
                    'All image processing is done locally on your device. Your images never leave your device and are not uploaded to any servers or third parties.',
                  ),
                  _buildSection(
                    context,
                    'Data Storage',
                    'The app only stores:\n\n• Your app preferences (theme, language, quality settings)\n• Converted images in your chosen storage location\n\nAll data remains on your device and under your control.',
                  ),
                  _buildSection(
                    context,
                    'Permissions',
                    'The app requests the following permissions:\n\n• Storage Access: To read images for conversion and save converted images\n• Photos Access: To access your photo library\n\nThese permissions are only used for their stated purposes.',
                  ),
                  _buildSection(
                    context,
                    'Third-Party Services',
                    'This app does not integrate with any third-party analytics, advertising, or tracking services.',
                  ),
                  _buildSection(
                    context,
                    'Children\'s Privacy',
                    'This app does not collect any information from anyone, including children under 13.',
                  ),
                  _buildSection(
                    context,
                    'Changes to Privacy Policy',
                    'We may update our Privacy Policy from time to time. Any changes will be reflected in the app with an updated "Last updated" date.',
                  ),
                  _buildSection(
                    context,
                    'Contact Us',
                    'If you have any questions about this Privacy Policy, please contact us through the app repository.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
