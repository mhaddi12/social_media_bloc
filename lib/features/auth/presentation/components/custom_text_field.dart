import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixIconTap,
                child: Icon(suffixIcon),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
