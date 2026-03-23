// lib/core/utils/responsive_helper.dart
import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;

  ResponsiveHelper(this.context);

  // Get screen size
  Size get screenSize => MediaQuery.of(context).size;

  // Get screen width
  double get screenWidth => screenSize.width;

  // Get screen height
  double get screenHeight => screenSize.height;

  // Get proportional width (percentage of screen width)
  double wp(double percentage) {
    return screenWidth * (percentage / 100);
  }

  // Get proportional height (percentage of screen height)
  double hp(double percentage) {
    return screenHeight * (percentage / 100);
  }

  // Get responsive font size
  double sp(double size) {
    // Base on screen width, with minimum size constraint
    return size * (screenWidth / 375).clamp(0.8, 1.2);
  }

  // Get responsive radius
  double r(double size) {
    return size * (screenWidth / 375).clamp(0.8, 1.2);
  }

  // Check if device is tablet
  bool get isTablet {
    return screenWidth >= 600;
  }

  // Check if device is desktop
  bool get isDesktop {
    return screenWidth >= 900;
  }

  // Get responsive value based on screen size
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // Get grid column count based on screen size
  int get gridColumnCount {
    if (screenWidth >= 900) return 4;
    if (screenWidth >= 600) return 3;
    return 2;
  }

  // Get padding based on screen size
  EdgeInsets get screenPadding {
    return EdgeInsets.all(
      responsiveValue(
        mobile: 16.0,
        tablet: 24.0,
        desktop: 32.0,
      ),
    );
  }
}