import 'package:flutter/cupertino.dart';
import 'package:flutter_component/components/input/number_step.dart';

class NumberCell extends StatelessWidget {
  final String? label;

  final TextStyle? labelTextStyle;

  final double? labelWidth;

  late final bool isInputDisable;

  late final int min;

  late final int max;

  late final int step;

  late final int defaultValue;

  late final Color bgColor;

  final Function(int value)? valueCallBack;

  NumberCell(
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
      Spacer(),
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
