import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/util/export_util.dart';

class BusinessLost extends StatelessWidget {
  final String text;

  final String reloadText;

  final TextStyle textStyle;

  final TextStyle reloadTextStyle;

  ///此处不需要设置网络图片读取。你断网了还能读远程？？？
  final String path;

  final Color borderColor;

  final Function()? onClickAction;

  BusinessLost(this.text, this.reloadText, this.path,
      {this.textStyle = const TextStyle(),
      this.reloadTextStyle = const TextStyle(),
      this.borderColor = Colors.white,
      this.onClickAction});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(path, fit: BoxFit.cover),
      PlaceHolder(
        axis: Axis.vertical,
        size: 21,
      ),
      Text(text, style: textStyle),
      PlaceHolder(
        axis: Axis.vertical,
        size: 18,
      ),
      GestureDetector(
        child: Container(
          height: 44,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            border: Border.all(width: 1, color: borderColor),
          ),
          child: Center(child: Text(reloadText, style: reloadTextStyle)),
        ),
        onTap: () => throttle(() => onClickAction?.call()),
      )
    ]));
  }
}
