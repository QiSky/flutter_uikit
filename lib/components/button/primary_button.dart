import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryButton extends StatelessWidget {
  final String text;

  final TextStyle textStyle;

  final Function()? onClickAction;

  final bool isInline;

  final Color color;

  final double radius;

  const PrimaryButton(this.color,
      {this.text = '',
      this.textStyle = const TextStyle(),
      this.onClickAction,
      this.isInline = true,
      this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        constraints: BoxConstraints(maxWidth: 92.0, maxHeight: 40.0),
        decoration: BoxDecoration(
            color: isInline ? color : Colors.transparent,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(radius)),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
