import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Utility class for showing toast-like notifications
class ToastHelper {
  /// Show success toast
  static void showSuccess(
    BuildContext context,
    String message, {
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    HapticFeedback.lightImpact();
    _showCustomSnackBar(
      context,
      message: message,
      subtitle: subtitle,
      icon: Icons.check_circle_rounded,
      backgroundColor: Colors.green.shade600,
      duration: duration,
    );
  }

  /// Show error toast
  static void showError(
    BuildContext context,
    String message, {
    String? subtitle,
    Duration duration = const Duration(seconds: 4),
  }) {
    HapticFeedback.mediumImpact();
    _showCustomSnackBar(
      context,
      message: message,
      subtitle: subtitle,
      icon: Icons.error_rounded,
      backgroundColor: Colors.red.shade600,
      duration: duration,
    );
  }

  /// Show info toast
  static void showInfo(
    BuildContext context,
    String message, {
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showCustomSnackBar(
      context,
      message: message,
      subtitle: subtitle,
      icon: Icons.info_rounded,
      backgroundColor: Colors.blue.shade600,
      duration: duration,
    );
  }

  /// Show warning toast
  static void showWarning(
    BuildContext context,
    String message, {
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showCustomSnackBar(
      context,
      message: message,
      subtitle: subtitle,
      icon: Icons.warning_rounded,
      backgroundColor: Colors.orange.shade600,
      duration: duration,
    );
  }

  static void _showCustomSnackBar(
    BuildContext context, {
    required String message,
    String? subtitle,
    required IconData icon,
    required Color backgroundColor,
    required Duration duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
