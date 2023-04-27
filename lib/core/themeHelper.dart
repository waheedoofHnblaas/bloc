import 'package:shared_preferences/shared_preferences.dart';

class ThemeHelper {
  Future<void> saveThemeIndex(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('themeIndex', index);
  }

  Future<int> getThemeIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('themeIndex') ?? 0;
  }
}
