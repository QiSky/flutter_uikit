import 'dart:async';
import 'dart:ui';

import 'package:flutter_component/util/timer_manager.dart';

void throttle(Function? func, {range: const Duration(milliseconds: 300)}) {
  if (!(TimerManager.getInstance()?.hasTimer('click') == true)) {
    func?.call();
    TimerManager.getInstance()?.startTimer(
        range, (timer) => TimerManager.getInstance()?.clearTimer('click'),
        key: 'click');
  }
}

Function debounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 200),
]) {
  Timer? timer;
  Function target = () {
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(delay, () {
      func.call();
    });
  };
  return target;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor, String opacity) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "").replaceAll('0X', '');
    if (hexColor.length == 6) hexColor = opacity + hexColor;
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor, {String opacity = "FF"})
      : super(_getColorFromHex(hexColor, opacity));
}
