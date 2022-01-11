import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class ParamsCell extends StatelessWidget {
  final String label;

  final TextStyle labelTextStyle;

  final double labelWidth;

  final dynamic defaultValue;

  final TextStyle valueTextStyle;

  final int number;

  final TextStyle numberTextStyle;

  final Color numberBgColor;

  const ParamsCell(
      {this.label = '',
      this.labelTextStyle = const TextStyle(),
      this.labelWidth = 80,
      this.defaultValue = '',
      this.valueTextStyle = const TextStyle(),
      this.number = 0,
      this.numberTextStyle = const TextStyle(),
      this.numberBgColor = const Color(0x204582FF)});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        width: labelWidth,
        child: Text(label, style: labelTextStyle),
      ),
      Expanded(
          child: Text(defaultValue.toString(),
              style: valueTextStyle, overflow: TextOverflow.ellipsis)),
      getNumberWidget(),
      const PlaceHolder(
        size: 5,
      ),
      const Icon(CupertinoIcons.chevron_right, color: Colors.grey, size: 18)
    ]);
  }

  Widget getNumberWidget() {
    if (number >= 0) {
      return ClipOval(
          child: Container(
        width: 22,
        height: 22,
        color: numberBgColor,
        child: Center(child: Text(number.toString(), style: numberTextStyle)),
      ));
    } else {
      return Container();
    }
  }
}
