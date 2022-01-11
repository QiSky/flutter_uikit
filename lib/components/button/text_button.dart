import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final double height;

  final EdgeInsetsGeometry padding;

  final double radius;

  final Color bgColor;

  final String? text;

  final TextStyle textStyle;

  final Function? onClickAction;

  const TextButton(
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
