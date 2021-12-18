import 'package:flutter/widgets.dart';

class DividingLine extends StatelessWidget {
  late final Color color;

  late final EdgeInsetsGeometry margin;

  late final double height;

  DividingLine(this.color,
      {this.margin = const EdgeInsets.symmetric(horizontal: 10),
      this.height = 0.5});

  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, color: color, height: height);
  }
}
