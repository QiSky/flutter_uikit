import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static late SharedPreferences _prefs;

  static late List<Type> _acceptedTypeList = [String, int, double, bool, List];

  static late var _prefixKey = "flu_";

  static void saveData(String key, dynamic data) async {
    await _init();
    assert(_acceptedTypeList.contains(data.runtimeType));
    if (data is String) _prefs.setString(_prefixKey + key, data);
    if (data is int) _prefs.setInt(_prefixKey + key, data);
    if (data is double) _prefs.setDouble(_prefixKey + key, data);
    if (data is bool) _prefs.setBool(_prefixKey + key, data);
    if (data is List<String>) _prefs.setStringList(_prefixKey + key, data);
  }

  static Future<dynamic> getData(String key) async {
    await _init();
    if (_prefs.containsKey(_prefixKey + key))
      return _prefs.get(_prefixKey + key);
    else
      return null;
  }

  static Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<List<String>?> getDataList(String key) async {
    await _init();
    if (_prefs.containsKey(_prefixKey + key))
      return _prefs.getStringList(_prefixKey + key);
    else
      return null;
  }

  static void deleteData(String key) async {
    await _init();
    _prefs.remove(_prefixKey + key);
  }

  static void deleteAllData() async {
    await _init();
    _prefs.clear();
  }
}
