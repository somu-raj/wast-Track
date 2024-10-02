import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String? labelText;
  final Widget? hint;
  final String? Function(Object?)? validator;
  final void Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object>>? items;
  final Object? value;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final double innerLeftPad;
  final double innerRightPad;

  const CustomDropdown(
      {Key? key,
      this.labelText,
      this.hint,
      this.validator,
      this.innerLeftPad = 0,
      this.innerRightPad = 15,
      required this.onChanged,
      required this.items,
      this.value,
      this.autovalidateMode,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        alignment: Alignment.center,
        borderRadius: BorderRadius.circular(15),
        elevation: 2,
        iconSize: 30,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        autovalidateMode: autovalidateMode,
        hint: hint,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.black),
          labelText: labelText,
          contentPadding:
              EdgeInsets.only(left: innerLeftPad, right: innerRightPad),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.customGrey,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.customGrey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.customGrey,
            ),
          ),
        ),
        validator: validator,
        value: value,
        onChanged: onChanged,
        items: items);
  }
}
