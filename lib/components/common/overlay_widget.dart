import 'dart:ui';

import 'package:flutter/material.dart';

///
/// * @ProjectName: flutter_uikit
/// * @Author: qifanxin
/// * @CreateDate: 2022/8/31 18:22
/// * @Description: 文件说明
///

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var widgetHeight = MediaQuery.of(context).size.height * 0.65;
    return Stack(
      alignment: Alignment.center,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        AlertDialog(
          elevation: 8,
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
          content: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: widgetHeight),
              child: child),
        )
      ],
    );
  }
}
