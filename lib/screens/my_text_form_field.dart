import 'package:attendance_management_system/consts.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyboardType,
      this.maxLines = 1,
      this.suffix,
      required this.label,
      this.textFieldWidth = double.maxFinite,
      this.focusNode,
      this.validator,
      this.obscureText = false,
      this.helperText});

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? suffix;
  final double textFieldWidth;
  final String? helperText;
  final String label;
  final bool obscureText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
      width: textFieldWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.02,
                  bottom: MediaQuery.sizeOf(context).width * 0.005),
              child: Text(label, style: Theme.of(context).textTheme.labelLarge),
            ),
            TextFormField(
              focusNode: focusNode,
              keyboardType: keyboardType,
              obscureText: obscureText,
              autocorrect: true,
              validator: validator,
              onChanged: (value) => controller.text = value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                  suffix: suffix,
                  helperText: helperText,
                  fillColor: AppColors.textFieldFillColor,
                  filled: true,
                  hintText: hintText,
                  hintStyle: TextStyle(color: AppColors.hintTextColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ),
    );
  }
}
