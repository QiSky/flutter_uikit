import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputCell extends StatelessWidget {
  final int maxLength;

  final int maxLine;

  final double cellTop;

  final String label;

  final TextEditingController textEditingController;

  final String hint;

  final TextInputType keyBorderType;

  final TextAlign textAlign;

  final Color bgColor;

  InputCell(this.label, this.textEditingController, this.bgColor,
      {this.maxLength = 10,
      this.maxLine = 1,
      this.cellTop = 0.0,
      this.hint = "",
      this.keyBorderType = TextInputType.text,
      this.textAlign = TextAlign.end});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      margin: EdgeInsets.only(top: cellTop),
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                label,
                style: TextStyle(fontSize: 16),
              )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: CupertinoTextField(
                controller: textEditingController,
                maxLength: maxLength,
                maxLines: maxLine,
                textAlign: textAlign,
                keyboardType: keyBorderType,
                placeholder: hint,
                clearButtonMode: OverlayVisibilityMode.editing,
                decoration: BoxDecoration(border: Border())),
          ))
        ],
      ),
    );
  }
}
