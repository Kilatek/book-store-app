import 'package:book_store/core/dimens/dimens.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  const RoundTextField({
    super.key,
    required this.hitText,
    required this.icon,
    this.controller,
    this.margin,
    this.keyboardType,
    this.obscureText = false,
    this.rigtIcon,
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(
          Dimens.d15,
        ),
      ),
      child: TextFormField(
        onTap: () {
          onTap!();
        },
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(
            Dimens.d15,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hitText,
          suffixIcon: rigtIcon,
          prefixIcon: Container(
              alignment: Alignment.center,
              width: Dimens.d20,
              height: Dimens.d20,
              child: Image.asset(
                icon,
                width: Dimens.d20,
                height: Dimens.d20,
                fit: BoxFit.contain,
                color: AppColors.gray,
              )),
          hintStyle: TextStyle(
            color: AppColors.gray,
            fontSize: Dimens.d12,
          ),
        ),
      ),
    );
  }
}
