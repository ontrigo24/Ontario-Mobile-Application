import 'package:flutter/material.dart';

import '../utils/global_variables.dart';
import '../utils/screen_size.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.showBorder = true,
    this.fillColor = Colors.transparent, this.titleStyle,
  });
  final VoidCallback onPressed;
  final String title;
  final bool showBorder;
  final Color fillColor;
  final TextStyle? titleStyle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSizeConfig.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeConfig.screenHeight * 0.018),
                width: ScreenSizeConfig.screenWidth -
                    (ScreenSizeConfig.screenWidth * 0.18),
                height: ScreenSizeConfig.screenHeight * 0.06,
                decoration: BoxDecoration(
                    color: fillColor,
                    border: Border.all(
                        color: showBorder
                            ? GlobalVariables.colors.secondary
                            : Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: titleStyle ?? TextStyle(
                    color: GlobalVariables.colors.secondary,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
