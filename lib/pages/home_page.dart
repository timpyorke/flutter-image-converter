import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../views/convert/convert_view.dart';
import '../views/resize/resize_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, navigationVM, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(navigationVM.isConvertSelected ? 'Convert' : 'Resize'),
            actions: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings coming soon!')),
                  );
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: navigationVM.isConvertSelected
              ? const ConvertView()
              : const ResizeView(),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  navigationVM: navigationVM,
                  icon: Icons.compare_arrows,
                  label: 'Convert',
                  index: 0,
                ),
                _buildNavItem(
                  context: context,
                  navigationVM: navigationVM,
                  icon: Icons.photo_size_select_large,
                  label: 'Resize',
                  index: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required NavigationViewModel navigationVM,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = navigationVM.selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: () => navigationVM.selectTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
