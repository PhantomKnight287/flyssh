import 'dart:io';

bool isPhone() {
  final phones = [Platform.isAndroid, Platform.isIOS];
  return phones.contains(true);
}

bool isDesktop() {
  final desktops = [Platform.isMacOS, Platform.isWindows, Platform.isLinux];
  return desktops.contains(true);
}
