import 'dart:convert';
import 'package:cnc_flutter_app/theme/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //
  static late SharedPreferences preferences;
  static const String KEY_SELECTED_THEME = 'key_selected_theme';

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveTheme(AppTheme selectedTheme) async {
    /*if (selectedTheme == null) {
      selectedTheme = AppTheme.Default;
    }*/
    String theme = jsonEncode(selectedTheme.toString());
    preferences.setString(KEY_SELECTED_THEME, theme);
  }

  static AppTheme? getTheme() {
    /*if (preferences == null){
      return AppTheme.Default;
    }*/
    String? theme = preferences.getString(KEY_SELECTED_THEME);
    if (theme == null) {
      return AppTheme.Default;
    }
    return getThemeFromString(jsonDecode(theme));
  }

  static AppTheme getThemeFromString(String themeString) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return AppTheme.Default;
  }
}
