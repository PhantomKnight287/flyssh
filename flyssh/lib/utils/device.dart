import 'dart:io';

import 'package:flutter/material.dart';

bool isPhone(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  const double phoneMaxWidth = 600;
  return screenWidth <= phoneMaxWidth;
}

bool isDesktop() {
  final desktops = [Platform.isMacOS, Platform.isWindows, Platform.isLinux];
  return desktops.contains(true);
}
