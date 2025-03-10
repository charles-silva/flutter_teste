part of 'app_textfield_base.dart';

class AppTextfield extends AppTextFieldBase {
  AppTextfield({
    super.key,
    required String super.hintText,
    super.controller,
    super.focusNode,
    super.keyboardType,
    super.validator,
    super.suffixIcon,
    super.prefixIcon,
    super.maxLenght,
    super.minLines,
    super.maxLines,
    bool? obscureText,
    super.inputFormatters,
    super.onSubmitted,
    super.onChanged,
  }) : super(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        );
}
