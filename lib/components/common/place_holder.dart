import 'package:flutter/widgets.dart';

class PlaceHolder extends StatelessWidget {
  late final Axis? axis;
  late final double? size;

  PlaceHolder({this.axis = Axis.horizontal, this.size = 16});

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.vertical) {
      return SizedBox(
        height: size,
      );
    } else {
      return SizedBox(
        width: size,
      );
    }
  }
}
