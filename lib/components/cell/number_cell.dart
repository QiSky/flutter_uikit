import 'package:flutter/cupertino.dart';
import 'package:flutter_component/components/input/number_step.dart';

class NumberCell extends StatelessWidget {
  final String? label;

  final TextStyle? labelTextStyle;

  final double? labelWidth;

  final bool isInputDisable;

  final int min;

  final int max;

  final int step;

  final int defaultValue;

  final Color bgColor;

  final Function(int value)? valueCallBack;

  const NumberCell(
      {this.label = "",
      this.labelTextStyle = const TextStyle(),
      this.labelWidth = 80,
      this.defaultValue = 0,
      this.isInputDisable = false,
      this.min = 0,
      this.max = 1000,
      this.step = 1,
      this.bgColor = const Color(0xFFEDF1F4),
      this.valueCallBack});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        width: labelWidth,
        child: Text(label ?? "", style: labelTextStyle),
      ),
      const Spacer(),
      Container(
          alignment: Alignment.centerRight,
          width: 200,
          child: NumberStep(
            min: min,
            max: max,
            step: step,
            bgColor: bgColor,
            isInputDisable: isInputDisable,
            defaultValue: defaultValue,
            valueCallBack: valueCallBack,
          ))
    ]);
  }
}
