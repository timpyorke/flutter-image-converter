import 'package:flutter/material.dart';
import '../../widgets/glass_widgets.dart';

class TermsOfServiceView extends StatelessWidget {
  const TermsOfServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
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
                    'Terms of Service',
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
                    'Acceptance of Terms',
                    'By downloading, installing, or using Image Converter, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the app.',
                  ),
                  _buildSection(
                    context,
                    'License',
                    'Image Converter grants you a personal, non-exclusive, non-transferable license to use the app for personal or commercial purposes in accordance with these terms.',
                  ),
                  _buildSection(
                    context,
                    'Use of the App',
                    'You agree to:\n\n• Use the app only for lawful purposes\n• Not attempt to reverse engineer or modify the app\n• Not use the app to process illegal or copyrighted content without proper authorization\n• Respect intellectual property rights of others',
                  ),
                  _buildSection(
                    context,
                    'Image Processing',
                    'All image processing is performed locally on your device. You retain all rights to your original images and converted images. The app developers claim no ownership or rights to any images you process.',
                  ),
                  _buildSection(
                    context,
                    'Disclaimer of Warranties',
                    'The app is provided "AS IS" without warranties of any kind, either express or implied. We do not warrant that:\n\n• The app will be error-free or uninterrupted\n• All image conversions will be successful\n• The app will meet your specific requirements',
                  ),
                  _buildSection(
                    context,
                    'Limitation of Liability',
                    'To the maximum extent permitted by law, the developers shall not be liable for any indirect, incidental, special, or consequential damages, including loss of data or images.',
                  ),
                  _buildSection(
                    context,
                    'User Responsibility',
                    'You are responsible for:\n\n• Maintaining backups of your original images\n• Ensuring you have the right to process images\n• The quality and accuracy of converted images\n• Compliance with applicable laws',
                  ),
                  _buildSection(
                    context,
                    'Updates and Changes',
                    'We reserve the right to modify or discontinue the app at any time. We may also update these Terms of Service, and continued use constitutes acceptance of modified terms.',
                  ),
                  _buildSection(
                    context,
                    'Termination',
                    'You may stop using the app at any time by uninstalling it from your device. We reserve the right to terminate or restrict access to the app for violation of these terms.',
                  ),
                  _buildSection(
                    context,
                    'Contact Information',
                    'For questions about these Terms of Service, please contact us through the app repository or support channels.',
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
