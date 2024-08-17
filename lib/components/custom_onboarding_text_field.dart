import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/global_variables.dart';

class CustomOnboardingTextField extends StatelessWidget {
  const CustomOnboardingTextField({
    super.key,
    required this.labelText,
    required this.sufixSvgIconPath,
    required this.borderRadius,
    required this.controller,
    this.obscureText = false,
    this.isEnabled = true,
  });

  final String labelText;
  final String sufixSvgIconPath;
  final BorderRadius borderRadius;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: isEnabled
                ? GlobalVariables.colors.inputFieldEnabledBorder
                : GlobalVariables.colors.textPrimary.withOpacity(0.28),
            width: 1.0,
          ),
          borderRadius: borderRadius,
        ),
        child: Align(
          alignment: const Alignment(0, 0.2),
          child: TextFormField(
            enabled: isEnabled,
            controller: controller,
            obscureText: obscureText, // To hide the password input
            decoration: InputDecoration(
              labelText: labelText,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  sufixSvgIconPath,
                  color: isEnabled
                      ? null
                      : GlobalVariables.colors.textPrimary.withOpacity(0.28),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
