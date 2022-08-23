import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

///
/// * @ProjectName: flutter_uikit
/// * @Author: qifanxin
/// * @CreateDate: 2022/8/23 15:34
/// * @Description: 文件说明
///

class NetworkListener {
  static NetworkListener? _instance;

  StreamSubscription? _streamSubscription;

  static NetworkListener getInstance() {
    _instance ??= NetworkListener();
    return _instance!;
  }

  void listen({VoidCallback? onEnable, VoidCallback? onDisable}) {
    _streamSubscription ??=
        Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        onEnable?.call();
      } else {
        onDisable?.call();
      }
    });
  }

  void dispose() {
    _streamSubscription?.cancel();
  }
}
