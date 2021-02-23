import 'package:shared_preferences/shared_preferences.dart';

String spTokenStr = "spTokenStr";

//single share preference class
class SharedPrefUtils {
  saveToken({String token}) async {
    (await SharedPreferences.getInstance()).setString(spTokenStr, token);
  }

  Future<String> getTokenOnly() async {
    return (await SharedPreferences.getInstance()).getString(spTokenStr);
  }

  logout() async {
    return (await SharedPreferences.getInstance()).clear();
  }
}
