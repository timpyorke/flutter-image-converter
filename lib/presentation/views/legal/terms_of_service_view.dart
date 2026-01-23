import 'package:flutter/material.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';
import '../../../core/widgets/widgets.dart';
import 'widgets/legal_section.dart';

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
                    context.l10n.termsOfService,
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
                    title: 'Acceptance of Terms',
                    content:
                        'By downloading, installing, or using Image Converter, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the app.',
                  ),
                  const LegalSection(
                    title: 'License',
                    content:
                        'Image Converter grants you a personal, non-exclusive, non-transferable license to use the app for personal or commercial purposes in accordance with these terms.',
                  ),
                  const LegalSection(
                    title: 'Use of the App',
                    content:
                        'You agree to:\n\n• Use the app only for lawful purposes\n• Not attempt to reverse engineer or modify the app\n• Not use the app to process illegal or copyrighted content without proper authorization\n• Respect intellectual property rights of others',
                  ),
                  const LegalSection(
                    title: 'Image Processing',
                    content:
                        'All image processing is performed locally on your device. You retain all rights to your original images and converted images. The app developers claim no ownership or rights to any images you process.',
                  ),
                  const LegalSection(
                    title: 'Disclaimer of Warranties',
                    content:
                        'The app is provided "AS IS" without warranties of any kind, either express or implied. We do not warrant that:\n\n• The app will be error-free or uninterrupted\n• All image conversions will be successful\n• The app will meet your specific requirements',
                  ),
                  const LegalSection(
                    title: 'Limitation of Liability',
                    content:
                        'To the maximum extent permitted by law, the developers shall not be liable for any indirect, incidental, special, or consequential damages, including loss of data or images.',
                  ),
                  const LegalSection(
                    title: 'User Responsibility',
                    content:
                        'You are responsible for:\n\n• Maintaining backups of your original images\n• Ensuring you have the right to process images\n• The quality and accuracy of converted images\n• Compliance with applicable laws',
                  ),
                  const LegalSection(
                    title: 'Updates and Changes',
                    content:
                        'We reserve the right to modify or discontinue the app at any time. We may also update these Terms of Service, and continued use constitutes acceptance of modified terms.',
                  ),
                  const LegalSection(
                    title: 'Termination',
                    content:
                        'You may stop using the app at any time by uninstalling it from your device. We reserve the right to terminate or restrict access to the app for violation of these terms.',
                  ),
                  const LegalSection(
                    title: 'Contact Information',
                    content:
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
}
