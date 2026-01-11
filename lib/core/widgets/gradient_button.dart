import 'dart:ui';
import 'package:flutter/material.dart';

/// Glassmorphism button with blur effect
class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double blur;
  final Color? color;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height = 56,
    this.borderRadius = 28,
    this.padding,
    this.blur = 10.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isEnabled = onPressed != null;

    // Use provided color or fallback to theme primary color
    final baseColor = color ?? theme.colorScheme.primary;

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.4)
                      : baseColor.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isEnabled
                    ? isDark
                          ? [
                              baseColor.withValues(alpha: 0.6),
                              baseColor.withValues(alpha: 0.4),
                            ]
                          : [
                              baseColor.withValues(alpha: 0.8),
                              baseColor.withValues(alpha: 0.6),
                            ]
                    : [
                        Colors.grey.withValues(alpha: 0.3),
                        Colors.grey.withValues(alpha: 0.2),
                      ],
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: isEnabled
                    ? isDark
                          ? baseColor.withValues(alpha: 0.5)
                          : baseColor.withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(borderRadius),
                splashColor: baseColor.withValues(alpha: 0.2),
                highlightColor: baseColor.withValues(alpha: 0.1),
                child: Container(
                  padding:
                      padding ?? const EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: isEnabled
                          ? isDark
                                ? Colors.white
                                : theme.colorScheme.onPrimary
                          : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
