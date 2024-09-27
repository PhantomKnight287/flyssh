import 'package:flutter/material.dart';
import 'package:flyssh/constants/colors.dart';

PreferredSizeWidget Bottom(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(4.0),
    child: Container(
      color: getSecondaryColor(
        context,
      ),
      height: 2.0,
    ),
  );
}
