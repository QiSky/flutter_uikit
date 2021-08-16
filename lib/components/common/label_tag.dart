import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/util/export_util.dart';

class LabelTag extends StatelessWidget {
  final double radius;

  final Color? bgColor;

  final String text;

  final TextStyle textStyle;

  final EdgeInsetsGeometry padding;

  final VoidCallback? clickAction;

  final BoxBorder? border;

  LabelTag(
      {this.radius = 4,
      this.bgColor = Colors.black,
      this.text = '',
      this.textStyle = const TextStyle(),
      this.padding =
          const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
      this.border = const Border(),
      this.clickAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: border,
            color: bgColor,
          ),
          padding: padding,
          child: Center(
            child: Text(text, style: textStyle),
          )),
      onTap: () => throttle(() => clickAction?.call()),
    );
  }
}
