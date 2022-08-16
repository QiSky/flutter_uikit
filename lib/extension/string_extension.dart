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

  static const String _domainExp =
      r'^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$';

  bool isPhone() {
    return RegExp(_phoneExp).hasMatch(this);
  }

  bool isEmail() {
    return RegExp(_emailExp).hasMatch(this);
  }

  bool isDomain() {
    return RegExp(_domainExp).hasMatch(this);
  }
}
