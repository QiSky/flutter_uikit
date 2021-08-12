class RegularUtil {
  static const String _phoneExp =
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$';

  static const String _emailExp =
      r'^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$';

  static bool isPhone(String value) {
    var exp = RegExp(_phoneExp);
    if (exp.hasMatch(value))
      return true;
    else {
      return false;
    }
  }

  static bool isEmail(String value) {
    var exp = RegExp(_emailExp);
    if (exp.hasMatch(value))
      return true;
    else {
      return false;
    }
  }
}
