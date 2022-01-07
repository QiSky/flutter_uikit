import 'package:flutter/widgets.dart';

class PlaceHolder extends StatelessWidget {
  final Axis? axis;
  final double? size;

  const PlaceHolder({this.axis = Axis.horizontal, this.size = 16});

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
