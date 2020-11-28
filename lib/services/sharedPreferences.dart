import 'package:shared_preferences/shared_preferences.dart';

saveId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('id', id);
}

getId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('id');
}

Future<bool> isLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('id');
}

Future<bool> getDarkMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('darkMode');
}

Future<bool> setDarkMode(bool darkMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool('darkMode', darkMode);
}
