import 'package:flutter/material.dart';

import 'app_color_scheme.dart';

class DarkColors extends AppColorScheme {
  @override
  Color get primary => const Color.fromARGB(255, 236, 135, 53);
  @override
  Color get secondary => Colors.black;
  @override
  Color get chatBubble => const Color(0xff3e3e3e);
  @override
  Color get unselectedNavBar => Colors.white70;
  @override
  Color get selectedNavBar => Colors.orange[800]!;
  @override
  Color get background => Colors.black;
  @override
  Color get inputFieldBackground => Colors.grey[800]!;
  @override
  Color get inputFieldCursor => const Color.fromARGB(255, 236, 135, 53);
  @override
  Color get inputFieldSuffixIcon => Colors.grey[400]!;
  @override
  Color get inputFieldFillColor => Colors.grey[850]!;
  @override
  Color get inputFieldHint => Colors.white70;
  @override
  Color get inputFieldFocusedBorder => const Color.fromARGB(255, 236, 135, 53);
  @override
  Color get inputFieldEnabledBorder => const Color.fromARGB(255, 236, 135, 53);
  @override
  Color get messageText => Colors.white;
  @override
  Color get messageBackground => Colors.grey[700]!;
  @override
  LinearGradient get primaryGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(255, 169, 99, 1),
          Color.fromRGBO(238, 143, 143, 1),
        ],
      );
  @override
  LinearGradient get unselectedCardGradient =>
      const LinearGradient(colors: [Colors.black, Colors.black]);

  @override
  // TODO: implement badgeColor
  Color get badgeColor => throw UnimplementedError();

  @override
  // TODO: implement error
  Color get error => throw UnimplementedError();

  @override
  // TODO: implement success
  Color get success => throw UnimplementedError();

  @override
  // TODO: implement warning
  Color get warning => throw UnimplementedError();

  @override
  // TODO: implement errorGradient
  LinearGradient get errorGradient => throw UnimplementedError();

  @override
  // TODO: implement successGradient
  LinearGradient get successGradient => throw UnimplementedError();
  
  @override
  // TODO: implement textSecondary
  Color get textSecondary => throw UnimplementedError();
}
