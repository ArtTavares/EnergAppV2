import 'package:shared_preferences/shared_preferences.dart';

saveId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('id', id);
}

getId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('id');
}

deslogarShared() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove('id');
}

Future<bool> isLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('id');
}
