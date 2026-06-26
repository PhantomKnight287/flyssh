import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
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
  final bool? enabled;
  final int? hintMaxLines;
  final bool? autoFocus;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final List<String>? autofillHints;
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;

  const InputField({
    required this.hintText,
    this.label,
    this.keyboardType,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.hintStyle,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.readOnly,
    this.border,
    this.fillColor,
    this.prefixIconColor,
    this.enabledBorder,
    this.enabled,
    this.hintMaxLines,
    this.autoFocus,
    this.onFieldSubmitted,
    this.onTap,
    this.focusNode,
    super.key,
    this.contentInsertionConfiguration,
    this.autofillHints,
    this.contentPadding,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
  });

  @override
  Widget build(BuildContext context) {
    final isMultiline = (maxLines != null && maxLines! > 1) ||
        (minLines != null && minLines! > 1);

    if (isMultiline) {
      return FTextFormField.multiline(
        control: FTextFieldControl.managed(controller: controller),
        label: label != null ? Text(label!) : null,
        hint: hintText,
        focusNode: focusNode,
        keyboardType: keyboardType,
        autofocus: autoFocus ?? false,
        readOnly: readOnly ?? false,
        onTap: onTap,
        contentInsertionConfiguration: contentInsertionConfiguration,
        maxLines: maxLines,
        minLines: minLines ?? 3,
        onSubmit: onFieldSubmitted,
        enabled: enabled ?? true,
        validator: validator,
        autofillHints: autofillHints ?? const [],
        prefixBuilder: prefixIcon != null
            ? (context, statesController, child) => prefixIcon!
            : null,
        suffixBuilder: suffixIcon != null
            ? (context, statesController, child) => suffixIcon!
            : null,
      );
    }

    if (obscureText == true) {
      return FTextFormField.password(
        control: FTextFieldControl.managed(controller: controller),
        label: label != null ? Text(label!) : null,
        hint: hintText,
        focusNode: focusNode,
        keyboardType: keyboardType,
        autofocus: autoFocus ?? false,
        readOnly: readOnly ?? false,
        onTap: onTap,
        contentInsertionConfiguration: contentInsertionConfiguration,
        onSubmit: onFieldSubmitted,
        enabled: enabled ?? true,
        validator: validator,
        autofillHints: autofillHints ?? const [],
      );
    }

    return FTextFormField(
      control: FTextFieldControl.managed(
        controller: controller,
        onChange: onChanged != null
            ? (value) => onChanged!(value.text)
            : null,
      ),
      label: label != null ? Text(label!) : null,
      hint: hintText,
      focusNode: focusNode,
      keyboardType: keyboardType,
      autofocus: autoFocus ?? false,
      readOnly: readOnly ?? false,
      onTap: onTap,
      contentInsertionConfiguration: contentInsertionConfiguration,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      onSubmit: onFieldSubmitted,
      enabled: enabled ?? true,
      validator: validator,
      autofillHints: autofillHints ?? const [],
      obscureText: obscureText ?? false,
      prefixBuilder: prefixIcon != null
          ? (context, statesController, child) => prefixIcon!
          : null,
      suffixBuilder: suffixIcon != null
          ? (context, statesController, child) => suffixIcon!
          : null,
    );
  }
}
