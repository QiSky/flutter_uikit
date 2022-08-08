import 'package:flutter/material.dart';

///
/// * @ProjectName: uikit
/// * @Author: qifanxin
/// * @CreateDate: 2022/8/7 16:15
/// * @Description: 文件说明
///
extension ThemeHelper on BuildContext {
  bool isDarkMode() {
    return Theme.of(this).brightness == Brightness.dark;
  }

  Color getModeColor(Color darkColor, Color lightColor) {
    return isDarkMode() ? darkColor : lightColor;
  }
}
