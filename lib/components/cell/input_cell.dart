import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class InputCell extends StatelessWidget {
  final int maxLength;

  final int maxLine;

  final String label;

  final TextEditingController textEditingController;

  final String hint;

  final TextInputType keyBorderType;

  final TextAlign textAlign;

  final Color bgColor;

  final double padding;

  final double fontSize;

  final bool isReadOnly;

  final Function? readOnlyClickAction;

  final double height;

  final Color fontColor;

  InputCell(this.label, this.textEditingController, this.bgColor,
      this.fontColor,
      {this.maxLength = 10,
      this.maxLine = 1,
      this.hint = "",
      this.keyBorderType = TextInputType.text,
      this.textAlign = TextAlign.end,
      this.padding = 12,
      this.fontSize = 16,
      this.isReadOnly = false,
      this.height = 45,
      this.readOnlyClickAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: bgColor,
      child: Row(
        children: <Widget>[
          PlaceHolder(size: padding),
          Text(
            label,
            style: TextStyle(fontSize: fontSize),
          ),
          Expanded(
              child: isReadOnly
                  ? CupertinoTextField(
                      controller: textEditingController,
                      maxLength: maxLength,
                      maxLines: maxLine,
                      textAlign: textAlign,
                      keyboardType: keyBorderType,
                      placeholder: hint,
                      style: TextStyle(fontSize: fontSize, color: fontColor),
                      decoration: BoxDecoration(border: Border()),
                      readOnly: isReadOnly,
                      onTap: () => readOnlyClickAction?.call(),
                    )
                  : CupertinoTextField(
                      controller: textEditingController,
                      maxLength: maxLength,
                      maxLines: maxLine,
                      textAlign: textAlign,
                      style: TextStyle(fontSize: fontSize, color: fontColor),
                      keyboardType: keyBorderType,
                      placeholder: hint,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      decoration: BoxDecoration(border: Border()),
                    )),
          PlaceHolder(size: padding),
        ],
      ),
    );
  }
}
