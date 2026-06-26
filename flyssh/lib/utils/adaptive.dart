import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatformHelper {
  // Platform checks
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktop => isMacOS || isWindows || isLinux;
  static bool get isWeb => kIsWeb;

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  // Convenience methods for common checks
  static bool get isApple => isMacOS || isIOS;
  static bool get supportsNativeWidgets => isAndroid;
  static bool get needsWindowManager => isDesktop;

  // Execute platform-specific code
  static T platformSwitch<T>({required T mobile, required T desktop, T? web}) {
    if (isWeb) return web ?? mobile;
    if (isDesktop) return desktop;
    return mobile;
  }

  // More granular control
  static T platformSelect<T>({
    T? android,
    T? iOS,
    T? macOS,
    T? windows,
    T? linux,
    T? web,
    required T fallback,
  }) {
    if (isWeb && web != null) return web;
    if (isAndroid && android != null) return android;
    if (isIOS && iOS != null) return iOS;
    if (isMacOS && macOS != null) return macOS;
    if (isWindows && windows != null) return windows;
    if (isLinux && linux != null) return linux;
    return fallback;
  }

  // Execute callback based on platform
  static void platformExecute({
    VoidCallback? onMobile,
    VoidCallback? onDesktop,
    VoidCallback? onAndroid,
    VoidCallback? onIOS,
    VoidCallback? onMacOS,
    VoidCallback? onWindows,
    VoidCallback? onLinux,
    VoidCallback? onWeb,
  }) {
    if (isWeb) {
      onWeb?.call();
    } else if (isAndroid) {
      if (onAndroid != null) {
        onAndroid.call();
      } else {
        onMobile?.call();
      }
    } else if (isIOS) {
      if (onIOS != null) {
        onIOS.call();
      } else {
        onMobile?.call();
      }
    } else if (isMacOS) {
      if (onMacOS != null) {
        onMacOS.call();
      } else {
        onDesktop?.call();
      }
    } else if (isWindows) {
      if (onWindows != null) {
        onWindows.call();
      } else {
        onDesktop?.call();
      }
    } else if (isLinux) {
      if (onLinux != null) {
        onLinux.call();
      } else {
        onDesktop?.call();
      }
    }
  }
}