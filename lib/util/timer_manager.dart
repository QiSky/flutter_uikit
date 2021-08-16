import 'dart:async';

class TimerManager {
  final Map<String, dynamic> _timerMap = {};

  /// 单例
  static TimerManager? _instance;

  static TimerManager? getInstance() {
    _instance ??= TimerManager();
    return _instance;
  }

  ///启动单次定时器
  void startTimerOnce(Function timerCallBack) {
    Timer.run(() => timerCallBack.call());
  }

  ///启动有间隔时间的多次定时器
  ///duration 定时的时间间隔
  ///widgetName 定时器设定为依赖widget
  ///key 定时器名称
  void startTimer(Duration duration, Function(Timer timer) timerCallBack,
      {String? widgetName, String? key}) {
    if (widgetName?.isNotEmpty == true) {
      List<Timer> list;
      if (_timerMap.containsKey(widgetName) && _timerMap[widgetName] != null) {
        list = _timerMap[widgetName] as List<Timer>;
      } else {
        list = [];
      }
      list.add(Timer.periodic(duration, (timer) {
        timerCallBack(timer);
      }));
      _timerMap[widgetName!] = list;
    } else if (key != null && key.isNotEmpty) {
      if (!hasTimer(key)) {
        _timerMap[key] = Timer.periodic(duration, (timer) {
          timerCallBack(timer);
        });
      }
    } else {
      throw ('widgetName和key必须填写一个');
    }
  }

  bool clearTimer(String timerName) {
    if (_timerMap.containsKey(timerName)) {
      var res = _timerMap[timerName];
      if (res == null) {
        return false;
      }
      if (res is List<Timer>) {
        autoRelease(timerName);
      } else {
        var timer = res as Timer;
        _timerMap.remove(timerName);
        timer.cancel();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<List<String>> getAllTimerName() async {
    _timerMap.forEach((key, value) {
      print('Timer name:$key');
    });
    return _timerMap.keys.toList();
  }

  bool hasTimer(String timerName) {
    return _timerMap.containsKey(timerName);
  }

  ///根据widgetName自动释放定时器
  void autoRelease(String widgetName) async {
    if (_timerMap.containsKey(widgetName)) {
      (_timerMap[widgetName] as List<Timer>).forEach((element) {
        if (element.isActive) element.cancel();
      });
      _timerMap.remove(widgetName);
    }
  }
}
