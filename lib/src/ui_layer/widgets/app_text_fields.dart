import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/src/data_layer/res/app_colors.dart';
import 'package:to_do_app/src/data_layer/res/numbers.dart';

/// Widget used to display common text field
class CustomTextField extends StatelessWidget {
  final int? maxLines;
  final bool readonly;
  final Widget? suffix;
  final int? maxLength;
  final bool showCounter;
  final String? hintText;
  final bool showBorders;
  final bool? obscureText;
  final TextAlign textAlign;
  final String? prefixImage;
  final VoidCallback? onTap;
  final Widget? prefixWidget;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final TextInputType? keyboardType;
  final ToolbarOptions? toolbarOptions;
  final TextInputAction? textInputAction;
  final VoidCallback? onVisibilityToggle;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final bool? isEnable;
  final TextStyle? hintStyle;
  final BoxConstraints? suffixBoxConstraints;
  final double inputFontSize;
  final bool autofocus;
  final bool expands;
  final Color? borderColor;
  final double radius;
  final String? errorText;

  const CustomTextField(
      {Key? key,
      this.onTap,
      this.suffix,
      this.hintText,
      this.focusNode,
      this.maxLength,
      this.validator,
      this.onChanged,
      this.prefixImage,
      this.obscureText,
      this.keyboardType,
      this.maxLines,
      this.prefixWidget,
      this.toolbarOptions,
      this.contentPadding,
      this.textInputAction,
      this.inputFormatters,
      this.onFieldSubmitted,
      this.readonly = false,
      this.onVisibilityToggle,
      this.controller,
      this.showCounter = false,
      this.showBorders = false,
      this.textAlign = TextAlign.start,
      this.textCapitalization = TextCapitalization.none,
      this.fillColor,
      this.isEnable = true,
      this.hintStyle,
      this.suffixBoxConstraints,
      this.inputFontSize = 20,
      this.autofocus = false,
      this.expands = false,
      this.borderColor,
      this.radius = 15,
      this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: expands,
      enabled: isEnable,
      onTap: onTap,
      readOnly: readonly,
      maxLines: maxLines,
      focusNode: focusNode,
      autofocus: autofocus,
      textAlign: textAlign,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      toolbarOptions: toolbarOptions,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      onFieldSubmitted: onFieldSubmitted,
      textCapitalization: textCapitalization,
      style: const TextStyle(
          fontSize: d_18,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
      decoration: InputDecoration(
          errorText: errorText ?? "",
          errorStyle: const TextStyle(
              color: Colors.redAccent, fontWeight: FontWeight.normal),
          label: Text(
            "$hintText",
          ),
          labelStyle: hintStyle,
          floatingLabelStyle: const TextStyle(
              color: AppColors.mainColor,
              fontSize: 18,
              fontWeight: FontWeight.w500),
          suffixIconConstraints: suffixBoxConstraints,
          hintText: hintText,
          hintStyle: hintStyle ??
              const TextStyle(
                  fontSize: d_16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.borderColor),
          errorMaxLines: 2,
          fillColor: fillColor,
          contentPadding: contentPadding,
          counterText: showCounter ? null : '',
          suffixIcon: suffix ?? const SizedBox.shrink(),
          prefixIcon: prefixWidget ?? const SizedBox.shrink(),
          border: showBorders ? _border() : null,
          errorBorder: showBorders ? _border() : null,
          enabledBorder: showBorders ? _activeBorder() : null,
          focusColor: AppColors.mainColor,
          focusedBorder: showBorders ? _activeBorder() : null,
          disabledBorder: showBorders ? _border() : null,
          focusedErrorBorder: showBorders ? _activeBorder() : null),
    );
  }

  /// text field border
  InputBorder _activeBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(d_8),
      borderSide:
          BorderSide(color: borderColor ?? AppColors.mainColor, width: 1.5),
    );
  }

  InputBorder _border() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor, width: 1.5));
  }
}
