import 'package:flutter/widgets.dart';

class HollowPoint extends StatelessWidget {
  final double? size;

  final double? innerSize;

  final Color? color;

  final Color? innerColor;

  final Color borderColor;

  final double borderSize;

  const HollowPoint(
      {this.size = 14,
      this.innerSize = 7,
      this.innerColor = const Color(0xFFF3F3F3),
      this.color = const Color(0xFFF3F3F3),
      this.borderColor = const Color(0xFFDFDFDF),
      this.borderSize = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: borderColor, width: borderSize)),
        child: Container(
            width: innerSize,
            height: innerSize,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: innerColor)));
  }
}
