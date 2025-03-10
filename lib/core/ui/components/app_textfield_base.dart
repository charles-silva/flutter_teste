import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_test/core/colors/app_colors.dart';

part 'app_text_field.dart';

class AppTextFieldBase extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final IconButton? suffixIcon;
  final IconButton? prefixIcon;
  final ValueNotifier<bool> _obscureTextVN;
  final int? maxLenght;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final OutlineInputBorder? border;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final ValueChanged<String>? onChanged;
  AppTextFieldBase({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.focusNode,
    this.validator,
    this.maxLenght,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
  })  : _obscureTextVN = ValueNotifier<bool>(obscureText),
        assert(
          obscureText == true ? suffixIcon == null : true,
          'obscureText não pode ser adicionado junto com o suffixicon',
        );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          maxLength: maxLenght,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onChanged: onChanged,
          textInputAction: textInputAction,
          onFieldSubmitted: onSubmitted,
          obscureText: obscureTextValue,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            fillColor: AppColors.textInputColor,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            prefixIcon: prefixIcon,
            suffixIcon: obscureText
                ? IconButton(
                    onPressed: () {
                      _obscureTextVN.value = !obscureTextValue;
                    },
                    icon: Icon(
                      obscureTextValue ? Icons.lock : Icons.lock_open,
                    ),
                  )
                : suffixIcon,
          ),
        );
      },
    );
  }
}
