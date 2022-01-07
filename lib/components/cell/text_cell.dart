import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextCell extends StatelessWidget {
  final String label;

  final TextStyle labelTextStyle;

  final String instruction;

  final TextStyle instructionTextStyle;

  final EdgeInsets padding;

  const TextCell(
      {this.label = '',
      this.labelTextStyle = const TextStyle(),
      this.instruction = '',
      this.instructionTextStyle = const TextStyle(),
      this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(label, style: labelTextStyle),
        const Spacer(),
        Text(
          instruction,
          style: instructionTextStyle,
        )
      ]),
    );
  }
}
