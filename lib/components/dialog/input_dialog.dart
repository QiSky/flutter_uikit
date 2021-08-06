
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class InputDialog extends StatelessWidget {

  final double elevation;

  final double maxHeight;

  final double maxWidth;

  final String positiveText;

  final String negativeText;

  final TextStyle positiveTextStyle;

  final TextStyle negativeTextStyle;

  final TextStyle titleStyle;

  final TextStyle contentStyle;

  final Function(String text) onPositiveAction;

  final Function() onNegativeAction;

  final Color bgColor;

  final Color negativeBgColor;

  final Color positiveBgColor;

  final String title;

  final Widget? titleChild;

  final int maxLength;

  final TextEditingController _controller = TextEditingController();

  final String placeholderText;

  final TextInputType inputType;

  InputDialog(this.title, this.positiveText,
      this.negativeText,
      this.onPositiveAction,
      this.onNegativeAction,
      {this.positiveTextStyle = const TextStyle(),
        this.elevation = 10,
        this.negativeTextStyle = const TextStyle(),
        this.titleStyle = const TextStyle(),
        this.contentStyle = const TextStyle(),
        this.bgColor = Colors.white,
        this.negativeBgColor = const Color(0xFFE3E4E6),
        this.positiveBgColor = const Color(0xFFE3E4E6),
        this.maxHeight = 180,
        this.maxWidth = 360,
        this.titleChild,
        this.maxLength = 11,
        this.placeholderText = '',
        this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
        ),
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
        padding: EdgeInsets.all(25),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleChild??Text(
              title,
              style: titleStyle,
            ),
            PlaceHolder(
              axis: Axis.vertical,
              size: 20,
            ),
            Expanded(child: SingleChildScrollView(
                child: Center(
                  child: CupertinoTextField(
                    controller: _controller,
                    keyboardType: inputType,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    placeholder: placeholderText,
                    maxLength: maxLength,
                  ),
                )
            )),
            PlaceHolder(
              axis: Axis.vertical,
              size: 25,
            ),
            Row(children: [
              Spacer(),
              CupertinoButton(
                  color: negativeBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  minSize: 40,
                  padding: EdgeInsets.only(left: 36, right: 36),
                  child: Text(
                    negativeText,
                    style: negativeTextStyle,
                  ),
                  onPressed: () => onNegativeAction.call()),
              PlaceHolder(
                size: 10,
              ),
              CupertinoButton(
                  color: positiveBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  minSize: 40,
                  padding: EdgeInsets.only(left: 36, right: 36),
                  child: Text(
                    positiveText,
                    style: positiveTextStyle,
                  ),
                  onPressed: () => onPositiveAction.call(_controller.text)),
              Spacer(),
            ])
          ],
        ),
      ),
    );
  }

}