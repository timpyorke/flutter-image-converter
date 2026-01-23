import 'package:flutter/material.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';
import '../../core/widgets/widgets.dart';
import 'widgets/legal_section.dart';

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
                    context.l10n.privacyPolicy,
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
                  const LegalSection(
                    title: 'Information We Collect',
                    content:
                        'Image Converter is designed with your privacy in mind. We do not collect, store, or transmit any personal information or data from your device.',
                  ),
                  const LegalSection(
                    title: 'How We Use Your Information',
                    content:
                        'All image processing is done locally on your device. Your images never leave your device and are not uploaded to any servers or third parties.',
                  ),
                  const LegalSection(
                    title: 'Data Storage',
                    content:
                        'The app only stores:\n\n• Your app preferences (theme, language, quality settings)\n• Converted images in your chosen storage location\n\nAll data remains on your device and under your control.',
                  ),
                  const LegalSection(
                    title: 'Permissions',
                    content:
                        'The app requests the following permissions:\n\n• Storage Access: To read images for conversion and save converted images\n• Photos Access: To access your photo library\n\nThese permissions are only used for their stated purposes.',
                  ),
                  const LegalSection(
                    title: 'Third-Party Services',
                    content:
                        'This app does not integrate with any third-party analytics, advertising, or tracking services.',
                  ),
                  const LegalSection(
                    title: 'Children\'s Privacy',
                    content:
                        'This app does not collect any information from anyone, including children under 13.',
                  ),
                  const LegalSection(
                    title: 'Changes to Privacy Policy',
                    content:
                        'We may update our Privacy Policy from time to time. Any changes will be reflected in the app with an updated "Last updated" date.',
                  ),
                  const LegalSection(
                    title: 'Contact Us',
                    content:
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
}
