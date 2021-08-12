import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginWayButton extends StatelessWidget {
  final Color bgColor;

  final Widget leftIcon;

  final String text;

  final TextStyle textStyle;

  final Color borderColor;

  final double leftPadding;

  final Function()? onClickAction;

  LoginWayButton(this.leftIcon, this.text,
      {this.onClickAction,
      this.leftPadding = 10.0,
      this.textStyle = const TextStyle(),
      this.bgColor = Colors.white,
      this.borderColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 45,
        width: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(23.5)),
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: leftPadding),
                child: leftIcon,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(text, style: textStyle),
            )
          ],
        ),
      ),
      onTap: onClickAction?.call(),
    );
  }
}
