import 'package:flutter/material.dart';
import 'package:flyssh/utils/adaptive.dart';

class AdaptiveHelper {
  /// 1. CONDITIONALLY RENDER WIDGETS

  /// Returns different widgets based on platform
  static Widget platform({
    required Widget mobile,
    required Widget desktop,
    Widget? web,
  }) {
    if (PlatformHelper.isWeb && web != null) return web;
    if (PlatformHelper.isDesktop) return desktop;
    return mobile;
  }

  /// More granular widget selection
  static Widget platformSelect({
    Widget? android,
    Widget? iOS,
    Widget? macOS,
    Widget? windows,
    Widget? linux,
    Widget? web,
    required Widget fallback,
  }) {
    if (PlatformHelper.isWeb && web != null) return web;
    if (PlatformHelper.isAndroid && android != null) return android;
    if (PlatformHelper.isIOS && iOS != null) return iOS;
    if (PlatformHelper.isMacOS && macOS != null) return macOS;
    if (PlatformHelper.isWindows && windows != null) return windows;
    if (PlatformHelper.isLinux && linux != null) return linux;
    return fallback;
  }

  /// Returns widget based on screen width
  static Widget responsive(
    BuildContext context, {
    required Widget mobile,
    Widget? tablet,
    required Widget desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  /// Show widget only on specific platforms
  static Widget? showOn({
    required Widget child,
    bool mobile = true,
    bool desktop = true,
    bool web = true,
  }) {
    if (PlatformHelper.isWeb && !web) return null;
    if (PlatformHelper.isDesktop && !desktop) return null;
    if (PlatformHelper.isMobile && !mobile) return null;
    return child;
  }

  /// 2. CONDITIONALLY STYLE WIDGETS

  /// Get value based on platform
  static T value<T>({
    required T mobile,
    required T desktop,
    T? web,
  }) {
    if (PlatformHelper.isWeb && web != null) return web;
    if (PlatformHelper.isDesktop) return desktop;
    return mobile;
  }

  /// EdgeInsets based on platform
  static EdgeInsets padding({
    required EdgeInsets mobile,
    required EdgeInsets desktop,
    EdgeInsets? web,
  }) {
    return value(mobile: mobile, desktop: desktop, web: web);
  }

  /// Common padding patterns
  static EdgeInsets get defaultPadding => value(
    mobile: EdgeInsets.all(16),
    desktop: EdgeInsets.all(24),
  );

  static EdgeInsets get smallPadding => value(
    mobile: EdgeInsets.all(8),
    desktop: EdgeInsets.all(12),
  );

  static EdgeInsets get largePadding => value(
    mobile: EdgeInsets.all(24),
    desktop: EdgeInsets.all(32),
  );

  /// Font size based on platform
  static double fontSize({
    required double mobile,
    required double desktop,
    double? web,
  }) {
    return value(mobile: mobile, desktop: desktop, web: web);
  }

  /// Icon size based on platform
  static double iconSize({
    double? mobile,
    double? desktop,
    double? web,
  }) {
    return value(
      mobile: mobile ?? 24,
      desktop: desktop ?? 20,
      web: web,
    );
  }

  /// Border radius based on platform
  static BorderRadius borderRadius({
    required BorderRadius mobile,
    required BorderRadius desktop,
    BorderRadius? web,
  }) {
    return value(mobile: mobile, desktop: desktop, web: web);
  }

  /// Max width for content
  static double get maxContentWidth => value(
    mobile: double.infinity,
    desktop: 1200,
  );

  /// Sidebar width
  static double get sidebarWidth => value(
    mobile: 0, // No sidebar on mobile
    desktop: 280,
  );

  /// 3. CONDITIONALLY RENDER PARENT WRAPPER

  /// Wrap widget with parent based on platform
  static Widget wrap({
    required Widget child,
    required Widget Function(Widget child) mobile,
    required Widget Function(Widget child) desktop,
    Widget Function(Widget child)? web,
  }) {
    if (PlatformHelper.isWeb && web != null) return web(child);
    if (PlatformHelper.isDesktop) return desktop(child);
    return mobile(child);
  }

  /// Center only on desktop
  static Widget centerOnDesktop(Widget child) {
    return wrap(
      child: child,
      mobile: (child) => child,
      desktop: (child) => Center(child: child),
    );
  }

  /// Constrain max width on desktop
  static Widget constrainOnDesktop(
    Widget child, {
    double maxWidth = 1200,
  }) {
    return wrap(
      child: child,
      mobile: (child) => child,
      desktop: (child) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }

  /// Add padding based on platform
  static Widget paddingWrapper(Widget child) {
    return Padding(
      padding: defaultPadding,
      child: child,
    );
  }

  /// Scrollable on mobile, fixed on desktop
  static Widget scrollableOnMobile(Widget child) {
    return wrap(
      child: child,
      mobile: (child) => SingleChildScrollView(child: child),
      desktop: (child) => child,
    );
  }

  /// SafeArea only on mobile
  static Widget safeAreaOnMobile(Widget child) {
    return wrap(
      child: child,
      mobile: (child) => SafeArea(child: child),
      desktop: (child) => child,
    );
  }

  /// Custom wrapper
  static Widget customWrap({
    required Widget child,
    Widget Function(Widget)? mobileWrapper,
    Widget Function(Widget)? desktopWrapper,
    Widget Function(Widget)? webWrapper,
  }) {
    if (PlatformHelper.isWeb && webWrapper != null) {
      return webWrapper(child);
    }
    if (PlatformHelper.isDesktop && desktopWrapper != null) {
      return desktopWrapper(child);
    }
    if (mobileWrapper != null) {
      return mobileWrapper(child);
    }
    return child;
  }

  /// Chain multiple wrappers
  static Widget multiWrap({
    required Widget child,
    bool center = false,
    bool safeArea = false,
    bool scrollable = false,
    bool constrain = false,
    double? maxWidth,
  }) {
    Widget result = child;

    if (constrain) {
      result = constrainOnDesktop(result, maxWidth: maxWidth ?? 1200);
    }

    if (center) {
      result = centerOnDesktop(result);
    }

    if (scrollable && PlatformHelper.isMobile) {
      result = SingleChildScrollView(child: result);
    }

    if (safeArea && PlatformHelper.isMobile) {
      result = SafeArea(child: result);
    }

    return result;
  }
}

/// Extension for easier access
extension AdaptiveContext on BuildContext {
  /// Check if mobile
  bool get isMobile => PlatformHelper.isMobile;

  /// Check if desktop
  bool get isDesktop => PlatformHelper.isDesktop;

  /// Get adaptive value
  T adaptive<T>({
    required T mobile,
    required T desktop,
    T? web,
  }) {
    return AdaptiveHelper.value(
      mobile: mobile,
      desktop: desktop,
      web: web,
    );
  }

  /// Get adaptive padding
  EdgeInsets get adaptivePadding => AdaptiveHelper.defaultPadding;

  /// Get responsive width breakpoint
  bool get isMobileWidth => MediaQuery.of(this).size.width < 600;
  bool get isTabletWidth {
    final width = MediaQuery.of(this).size.width;
    return width >= 600 && width < 1200;
  }

  bool get isDesktopWidth => MediaQuery.of(this).size.width >= 1200;

  /// Combined check: platform AND width
  bool get shouldUseMobileLayout => isMobile || isMobileWidth;
  bool get shouldUseDesktopLayout => isDesktop && isDesktopWidth;
}