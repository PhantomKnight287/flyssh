import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

Future<bool?> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmLabel = "Delete",
  String cancelLabel = "Cancel",
  bool destructive = true,
}) {
  return showFDialog<bool>(
    context: context,
    builder: (ctx, style, animation) => FDialog(
      style: style,
      animation: animation,
      direction: Axis.horizontal,
      title: Text(title),
      body: Text(message),
      actions: [
        FButton(
          variant: destructive
              ? FButtonVariant.destructive
              : FButtonVariant.primary,
          onPress: () => Navigator.of(ctx).pop(true),
          child: Text(confirmLabel),
        ),
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.of(ctx).pop(false),
          child: Text(cancelLabel),
        ),
      ],
    ),
  );
}
