import 'package:flutter/material.dart';

import 'app_color_scheme.dart';


class LightColors extends AppColorScheme {
  @override
  Color get primary => const Color(0xF66D1F);
  @override
  Color get secondary => Colors.white;
  @override
  Color get chatBubble => const Color(0xffFBE6BD);
  @override
  Color get unselectedNavBar => Colors.black87;
  @override
  Color get selectedNavBar => Colors.orange[800]!;
  @override
  Color get background => Colors.white;
  @override
  Color get inputFieldBackground => Colors.grey[200]!;
  @override
  Color get inputFieldCursor => const Color.fromARGB(255, 236, 135, 53);
  @override
  Color get inputFieldSuffixIcon => Colors.grey[700]!;
  @override
  Color get inputFieldFillColor => Colors.white;
  @override
  Color get inputFieldHint => const Color(0xFF9E9E9E);
  @override
  Color get inputFieldFocusedBorder => const Color.fromARGB(255, 236, 135, 53);
  @override
  Color get inputFieldEnabledBorder => const Color.fromARGB(255, 236, 135, 53);
  @override
  Color get messageText => Colors.black;
  @override
  Color get messageBackground => Colors.grey[300]!;
  @override
  LinearGradient get primaryGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFA963),
      Color(0xFFEE8F8F),
    ],
  );
  @override
  LinearGradient get unselectedCardGradient =>
      const LinearGradient(colors: [Colors.white, Colors.white]);

  @override
  Color get badgeColor => Colors.red;

  @override
  Color get error => Colors.red;

  @override
  Color get success => Colors.green;

  @override
  Color get warning => Colors.yellow;

  @override
  LinearGradient get errorGradient => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFFF4E4E),
      Color(0xFFFFB1B1),
    ],
  );

  @override
  LinearGradient get successGradient => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF00FFA8),
      Color(0xFF4EFEFF),
    ],
  );
  
  @override
  Color get textSecondary => const Color(0x00141414);
}