import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/circle_image.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/constant/image_constant.dart';

class MessageCell extends StatelessWidget {
  late final String path;

  late final double imageWidth;

  late final double imageHeight;

  late final ImageType imageType;

  late final String title;

  late final String subTitle;

  late final TextStyle titleStyle;

  late final TextStyle subTitleStyle;

  late final String time;

  late final TextStyle timeStyle;

  late final double itemHeight;

  late final Color bgColor;

  MessageCell(this.path, this.title, this.subTitle, this.time, this.bgColor,
      {this.titleStyle = const TextStyle(),
      this.subTitleStyle = const TextStyle(),
      this.timeStyle = const TextStyle(),
      this.imageWidth = 58,
      this.imageHeight = 58,
      this.itemHeight = 100,
      this.imageType = ImageType.NETWORK});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: itemHeight,
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          CircleImage(path,
              imageHeight: imageHeight,
              imageWidth: imageWidth,
              imageType: imageType),
          const PlaceHolder(size: 20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Spacer(),
            Text(title, style: titleStyle),
            const PlaceHolder(axis: Axis.vertical, size: 5),
            Text(subTitle, style: subTitleStyle),
            const Spacer()
          ]),
          const Spacer(),
          Column(children: [
            const Spacer(),
            Text(time, style: timeStyle),
            const PlaceHolder(axis: Axis.vertical, size: 5),
            const Text(''),
            const Spacer()
          ])
        ]));
  }
}
