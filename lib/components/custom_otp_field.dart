import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/global_variables.dart';

class CustomOtpField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final bool isEnabled;

  const CustomOtpField({super.key, this.onChanged, this.isEnabled = true});

  @override
  // ignore: library_private_types_in_public_api
  _CustomOtpFieldState createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());

    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        _onTextChanged();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    String otp = _controllers.map((controller) => controller.text).join();
    if (widget.onChanged != null) {
      widget.onChanged!(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 50,
          child: TextField(
            enabled: widget.isEnabled,
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.isEnabled
                      ? GlobalVariables.colors.inputFieldEnabledBorder
                      : GlobalVariables.colors.textPrimary.withOpacity(0.28),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.isEnabled
                      ? GlobalVariables.colors.inputFieldEnabledBorder
                      : GlobalVariables.colors.textPrimary.withOpacity(0.28),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.isEnabled
                      ? GlobalVariables.colors.inputFieldEnabledBorder
                      : GlobalVariables.colors.textPrimary.withOpacity(0.28),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.isEnabled
                      ? GlobalVariables.colors.inputFieldEnabledBorder
                      : GlobalVariables.colors.textPrimary.withOpacity(0.28),
                ),
              ),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              if (value.length == 1 && index < _focusNodes.length - 1) {
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
            onSubmitted: (_) {
              if (index < _focusNodes.length - 1) {
                _focusNodes[index + 1].requestFocus();
              }
            },
            onTap: () async {
              // Check if the clipboard contains data and if it's of length 4
              ClipboardData? clipboardData = await Clipboard.getData('text/plain');
              if (clipboardData != null && clipboardData.text != null && clipboardData.text!.length == 4) {
                for (int i = 0; i < clipboardData.text!.length; i++) {
                  _controllers[i].text = clipboardData.text![i];
                }
                _onTextChanged();  // Update OTP value and notify listener
              }
            },
          ),
        );
      }),
    );
  }
}
