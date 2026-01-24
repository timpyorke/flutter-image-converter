import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_image_converters/l10n/app_localizations.dart';
import 'package:flutter_image_converters/features/settings/settings_viewmodel.dart';
import 'package:flutter_image_converters/features/tutorial/widgets/tutorial_page.dart';

class TutorialView extends StatefulWidget {
  const TutorialView({super.key});

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onFinish() {
    context.read<SettingsViewModel>().completeTutorial();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentPage < 2)
                    TextButton(
                      onPressed: _onFinish,
                      child: Text(
                        l10n.skip,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.5),
                        ),
                      ),
                    )
                  else
                    const SizedBox(
                        height: 48), // Placeholder to keep layout stable
                ],
              ),
            ),

            // Content
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color ??
                      Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    TutorialPage(
                      title: l10n.tutorialWelcomeTitle,
                      description: l10n.tutorialWelcomeDescription,
                      imagePath: 'assets/images/tutorial_welcome.png',
                    ),
                    TutorialPage(
                      title: l10n.tutorialConvertTitle,
                      description: l10n.tutorialConvertDescription,
                      imagePath: 'assets/images/tutorial_convert.png',
                    ),
                    TutorialPage(
                      title: l10n.tutorialResizeTitle,
                      description: l10n.tutorialResizeDescription,
                      imagePath: 'assets/images/tutorial_resize.png',
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indicators
                  Row(
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  // Action Button
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _currentPage == 2
                        ? FilledButton(
                            key: const ValueKey('start'),
                            onPressed: _onFinish,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                            ),
                            child: Text(l10n.getStarted),
                          )
                        : FilledButton.tonal(
                            key: const ValueKey('next'),
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                            ),
                            child: Text(l10n.next),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
