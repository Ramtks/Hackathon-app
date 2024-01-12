import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackathon_app/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.hintText,
    required this.showError,
    required this.onChange,
    this.borderRadius = 8,
    this.initialText,
    this.textInputType,
    this.labelText,
    this.inputFormatters,
    super.key,
    this.errorText = '',
    this.isObsecure = false,
    this.isErrorTop = false,
  });
  final bool showError;
  final String? initialText;
  final String hintText;
  final String? labelText;
  final String errorText;
  final double borderRadius;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChange;
  final bool isObsecure;
  final bool isErrorTop;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          widget.isErrorTop ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 6),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: widget.labelText,
                    style: Theme.of(context).textTheme.titleLarge,
                    children: [
                      if (widget.showError)
                        TextSpan(
                          text: ' (${widget.errorText})',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.primaryRed),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (widget.errorText != '' &&
            widget.showError &&
            widget.labelText == null &&
            widget.isErrorTop)
          SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.errorText,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.primaryRed),
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(
              widget.borderRadius,
            ),
          ),
          height: 48,
          child: TextFormField(
          
            obscureText: !isVisible && widget.isObsecure,
            controller: _controller,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.textInputType,
            onChanged: widget.onChange,
            cursorColor: AppColors.boxColor,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
              suffixIcon: widget.isObsecure
                  ? GestureDetector(
                      onTap: () => setState(() {
                        isVisible = !isVisible;
                      }),
                      child: Icon(
                        isVisible
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 20,
                        color: isVisible
                            ? AppColors.buttonColor1
                            : AppColors.disabledButtonColor,
                      ),
                    )
                  : null,
              // suffixIconColor: AppColors.grey,
              contentPadding: EdgeInsetsDirectional.only(
                start: widget.borderRadius == 8 ? 15 : 20,
                top: 25,
              ),
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.showError
                      ? AppColors.primaryRed
                      : AppColors.boxColor,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.showError
                      ? AppColors.primaryRed
                      : AppColors.boxColor,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.showError
                      ? AppColors.primaryRed
                      : AppColors.boxColor,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              hintStyle: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        if (widget.errorText != '' &&
            widget.showError &&
            widget.labelText == null &&
            !widget.isErrorTop)
          SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.errorText,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.primaryRed),
                ),
              ],
            ),
          )
      ],
    );
  }
}
