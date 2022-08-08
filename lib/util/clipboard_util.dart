import 'package:flutter/services.dart';

class ClipboardUtil {
  //获取内容
  static Future<String?> getData() async {
    ClipboardData data = (await Clipboard.getData(Clipboard.kTextPlain))!;
    return data.text;
  }
}
