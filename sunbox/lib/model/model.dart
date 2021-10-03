import 'package:shared_preferences/shared_preferences.dart';
class Model{
  static Future<void> setValue(text) async {
    SharedPreferences.setMockInitialValues({"markers":""});
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("markers", text);
  }

  static Future<String> getValue() async {
    var prefs;
    try{
      prefs = await SharedPreferences.getInstance();
    }catch(e){
      SharedPreferences.setMockInitialValues({"markers":""});
      prefs = await SharedPreferences.getInstance();
    }

    return prefs.getString("markers") ?? "";
  }
}