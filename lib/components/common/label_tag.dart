import 'package:flutter/material.dart';
import 'package:flutter_component/util/export_util.dart';

class LabelTag extends StatelessWidget {
  final double radius;

  final Color? bgColor;

  final String text;

  final TextStyle textStyle;

  final EdgeInsetsGeometry padding;

  final VoidCallback? clickAction;

  final VoidCallback? longTapAction;

  final BoxBorder? border;

  const LabelTag(
      {this.radius = 4,
      this.bgColor = Colors.black,
      this.text = '',
      this.textStyle = const TextStyle(),
      this.padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      this.border = const Border(),
      this.clickAction,
      this.longTapAction});

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
              child: Text(
                text,
                style: textStyle,
                overflow: TextOverflow.ellipsis,
              ),
            )),
        onTap: () => throttle(() => clickAction?.call()),
        onLongPress: () => longTapAction?.call());
  }
}
