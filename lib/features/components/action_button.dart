import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hackathon_app/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.buttonText,
    required this.onPressed,
    super.key,
    this.fontsize,
    this.fontWeight,
    this.isDisabled = false,
    this.isLoading = false,
    this.isFloating = false,
  });
  final String buttonText;
  final bool isLoading;
  final VoidCallback onPressed;
  final double? fontsize;
  final FontWeight? fontWeight;
  final bool isDisabled;
  final bool isFloating;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.backgroundColor,
      height: isFloating ? 112 : null,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isFloating ? 24 : 0),
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: RadialGradient(
            transform: const GradientRotation(pi / 4),
            radius: 10,
            center: Alignment.centerLeft,
            colors: isDisabled
                ? [AppColors.disabledButtonColor, AppColors.disabledButtonColor]
                : [AppColors.buttonColor1, AppColors.buttonColor2],
          ),
        ),
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          child: isLoading
              ? LoadingAnimationWidget.hexagonDots(
                  color: Colors.white,
                  size: 28,
                )
              : Text(
                  buttonText,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: fontsize,
                        color: isDisabled
                            ? AppColors.disabledButtonTextColor
                            : AppColors.buttonTextColor,
                      ),
                ),
        ),
      ),
    );
  }
}
