import 'package:book_store/core/dimens/dimens.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum RoundButtonType { bgGradient, bgSGradient, textGradient }

class RoundButton extends StatelessWidget {
  final String title;
  final RoundButtonType type;
  final VoidCallback onPressed;
  final double fontSize;
  final double elevation;
  final FontWeight fontWeight;
  final bool isLoading;

  const RoundButton({
    super.key,
    required this.title,
    this.type = RoundButtonType.bgGradient,
    this.fontSize = Dimens.d15,
    this.elevation = 1,
    this.fontWeight = FontWeight.w700,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: type == RoundButtonType.bgSGradient
                ? AppColors.secondaryG
                : AppColors.primaryG,
          ),
          borderRadius: BorderRadius.circular(Dimens.d25),
          boxShadow: type == RoundButtonType.bgGradient ||
                  type == RoundButtonType.bgSGradient
              ? const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.5,
                    offset: Offset(0, 0.5),
                  ),
                ]
              : null),
      child: MaterialButton(
        onPressed: onPressed,
        height: Dimens.d50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textColor: AppColors.primaryColor1,
        minWidth: double.maxFinite,
        elevation: type == RoundButtonType.bgGradient ||
                type == RoundButtonType.bgSGradient
            ? 0
            : elevation,
        color: type == RoundButtonType.bgGradient ||
                type == RoundButtonType.bgSGradient
            ? Colors.transparent
            : AppColors.white,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              )
            : type == RoundButtonType.bgGradient ||
                    type == RoundButtonType.bgSGradient
                ? Text(
                    title,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  )
                : ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: AppColors.primaryG,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(
                        Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                      );
                    },
                    child: Text(
                      title,
                      style: TextStyle(
                        color: AppColors.primaryColor1,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ),
      ),
    );
  }
}
