import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/circle_image.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/constant/image_constant.dart';

class IdentityCard extends StatelessWidget {
  final double radius;

  final double elevation;

  final EdgeInsetsGeometry margin;

  final Color startBgColor;

  final Color stopBgColor;

  final String text;

  final TextStyle textStyle;

  final String subText;

  final TextStyle subTextStyle;

  late final String path;

  late final ImageType imageType;

  final double imageHeight;

  final double imageWidth;

  final Color rightIconColor;

  final double rightIconSize;

  final double height;

  IdentityCard(
    this.text,
    this.subText,
    this.path, {
    this.radius = 12,
    this.elevation = 2,
    this.margin = const EdgeInsets.only(left: 15, right: 15),
    this.startBgColor = const Color(0xFFFF9C2D),
    this.stopBgColor = const Color(0xFFFF7E00),
    this.textStyle = const TextStyle(),
    this.subTextStyle = const TextStyle(),
    this.imageHeight = 72,
    this.imageWidth = 72,
    this.imageType = ImageType.LOCAL,
    this.rightIconColor = Colors.white,
    this.rightIconSize = 20,
    this.height = 144,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
      margin: margin,
      elevation: elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            gradient: LinearGradient(colors: [startBgColor, stopBgColor])),
        child: Row(
          children: [
            PlaceHolder(size: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: textStyle,
                ),
                PlaceHolder(
                  axis: Axis.vertical,
                ),
                Text(
                  subText,
                  style: subTextStyle,
                )
              ],
            ),
            Spacer(),
            CircleImage(
              path,
              imageHeight: imageHeight,
              imageWidth: imageWidth,
              imageType: imageType,
            ),
            PlaceHolder(),
            Icon(CupertinoIcons.chevron_right,
                color: rightIconColor, size: rightIconSize),
            PlaceHolder(size: 10,),
          ],
        ),
      ),
    ));
  }
}
