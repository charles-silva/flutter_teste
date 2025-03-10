import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/colors/app_colors.dart';

class AppButtom extends StatelessWidget {
  final Widget label;
  final void Function()? onPressed;
  const AppButtom({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          return (states.contains(WidgetState.disabled)) ? Colors.grey : AppColors.buttomColor; // Regular color
        }),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          const Size(double.infinity, 48),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onPressed: onPressed,
      child: label,
    );
  }
}
