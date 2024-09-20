import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final InputBorder? border;
  final Function(String)? onChanged;
  final Color? fillColor;
  final Color? prefixIconColor;
  final InputBorder? enabledBorder;

  const InputField({
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.validator,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.hintStyle,
    super.key,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.readOnly,
    this.border,
    this.fillColor,
    this.prefixIconColor,
    this.enabledBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText ?? false,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.all(8.0),
        enabledBorder: enabledBorder,
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
        prefixIconColor: AdaptiveTheme.of(context).mode.isDark ? Colors.grey : Colors.black,
        fillColor: fillColor ?? (AdaptiveTheme.of(context).mode.isLight ? Colors.grey.shade200 : Colors.grey.shade800),
        filled: true,
        hintStyle: hintStyle,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
