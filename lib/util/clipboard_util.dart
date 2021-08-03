import 'package:flutter/services.dart';

class ClipboardUtil {

  //复制内容
  static bool setData(String? data) {
    if (data != null && data.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: data));
      return true;
    }
    return false;
  }

  //获取内容
  static Future<String?> getData() async{
    ClipboardData data=(await Clipboard.getData(Clipboard.kTextPlain))!;
    return data.text;
  }

}