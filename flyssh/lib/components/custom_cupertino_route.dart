import 'dart:io';
import 'package:flutter/cupertino.dart';

class CustomCupertinoRoute<T> extends CupertinoPageRoute<T> {
  CustomCupertinoRoute({
    required super.builder,
    super.title,
    super.settings,
    super.maintainState = true,
    super.fullscreenDialog,
    super.allowSnapshotting = true,
    this.isPopGestureEnabled = false,
  });

  /// Whether a pop gesture can be started by the user.
  /// Returns true if the user can edge-swipe to a previous route.
  /// By default, this is enabled only on iOS and MacOS.
  final bool? isPopGestureEnabled;

  @override
  bool get hasScopedWillPopCallback {
    if (Platform.isIOS || Platform.isMacOS) {
      // ignore: deprecated_member_use
      return super.hasScopedWillPopCallback;
    } else {
      return true;
    }
  }

  @override
  bool get popGestureEnabled {
    if (Platform.isIOS || Platform.isMacOS) {
      return true;
    } else if (Platform.isAndroid) {
      return false;
    }
    return isPopGestureEnabled ?? false;
  }
}
