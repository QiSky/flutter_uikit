import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextButton extends StatelessWidget {
  late final double height;

  late final EdgeInsetsGeometry padding;

  late final double radius;

  late final Color bgColor;

  final String? text;

  late final TextStyle textStyle;

  Function? onClickAction;

  TextButton(
      {this.height = 60,
      this.padding = EdgeInsets.zero,
      this.radius = 8,
      this.bgColor = Colors.blue,
      this.text = '',
      this.textStyle = const TextStyle(),
      this.onClickAction});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: padding,
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: bgColor,
            child: Center(
              child: Text(text ?? '', style: textStyle),
            ),
            onPressed: () => onClickAction?.call()));
  }
}
