
import 'dart:io';

import 'package:flutter/widgets.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver{

  late String widgetName;

  late String stateName;

  //回退间隔时间
  DateTime? _lastPopTime;

  //短暂双击退出app
  Future<bool> exitApp({Function? intervalFunction, Function? exitFunction}) async {
    if (_lastPopTime == null || DateTime.now().difference(_lastPopTime!) > Duration(seconds: 2)) {
      _lastPopTime = DateTime.now();
      intervalFunction?.call();
      return false;
    } else {
      _lastPopTime = DateTime.now();
      exitFunction?.call();
      return true;
    }
  }

  Widget popWidget(Widget widget, Future<bool> Function() popAction) {
    if(Platform.isAndroid) {
      return WillPopScope(
          onWillPop: popAction,
          child: widget
      );
    } else {
      return widget;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    widgetName = (widget).toString();
    stateName = toString();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

}