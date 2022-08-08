import 'package:flutter/services.dart';

///
/// * @ProjectName: flutter_uikit
/// * @Author: qifanxin
/// * @CreateDate: 2022/8/8 11:48
/// * @Description: 文件说明
///

extension ClipBoardHelper on String {
  //复制内容
  bool setClipBoardData() {
    if (this.isNotEmpty == true) {
      Clipboard.setData(ClipboardData(text: this));
      return true;
    }
    return false;
  }
}

extension RegularHelper on String {
  static const String _phoneExp =
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$';

  static const String _emailExp =
      r'^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$';

  bool isPhone() {
    var exp = RegExp(_phoneExp);
    return exp.hasMatch(this);
  }

  bool isEmail() {
    var exp = RegExp(_emailExp);
    return exp.hasMatch(this);
  }
}
