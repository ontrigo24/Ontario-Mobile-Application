import 'app_color_scheme.dart'; // Import the abstract class defining the color scheme contract
import 'dark_colors.dart'; // Import the dark color scheme implementation
import 'light_colors.dart'; // Import the light color scheme implementation

/// Singleton class to manage theme switching between light and dark color schemes
class ThemeManager {
  // Singleton instance of ThemeManager
  static final ThemeManager _instance = ThemeManager._internal();

  // The current color scheme being used
  late AppColorScheme colorScheme;

  /// Factory constructor to return the singleton instance
  factory ThemeManager() {
    return _instance;
  }

  /// Private constructor to initialize the default color scheme
  ThemeManager._internal() {
    colorScheme = LightColors(); // Set the default theme to light
  }

  /// Method to switch to the light theme
  void switchToLightTheme() {
    colorScheme = LightColors(); // Change the color scheme to light
  }

  /// Method to switch to the dark theme
  void switchToDarkTheme() {
    colorScheme = DarkColors(); // Change the color scheme to dark
  }
}
