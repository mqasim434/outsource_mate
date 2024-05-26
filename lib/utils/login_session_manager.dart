import 'package:shared_preferences/shared_preferences.dart';

class LoginSessionManager{
  static Future<void> storeUserSession(String email, String collection) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('collection', collection);
  }

  static Future<String?> getUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    if (email != null) {
      return email;
    } else {
      return null;
    }
  }

}