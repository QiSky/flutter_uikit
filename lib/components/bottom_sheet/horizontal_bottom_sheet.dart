import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/constant/image_constant.dart';
import 'package:flutter_component/util/export_util.dart';

class HorizontalOverlyEntry {
  late final ImageType imageType;

  late final String imagePath;

  late final String text;

  HorizontalOverlyEntry(this.imagePath, this.text,
      {this.imageType = ImageType.LOCAL});
}

class HorizontalBottomSheet extends StatelessWidget {
  late final double radius;

  late final double height;

  late final List<HorizontalOverlyEntry> list;

  late final String title;

  late final TextStyle labelTextStyle;

  late final Color bgColor;

  final Function(String name)? onClickAction;

  HorizontalBottomSheet(
      {this.bgColor = Colors.white,
      this.radius = 24,
      this.height = 300,
      this.list = const [],
      this.title = '',
      this.labelTextStyle = const TextStyle(),
      this.onClickAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: height),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        PlaceHolder(
          axis: Axis.vertical,
          size: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlaceHolder(size: 20),
            Text(title,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF18191A),
                    fontWeight: FontWeight.w600)),
            Spacer(),
            GestureDetector(
              child: Icon(
                CupertinoIcons.clear,
                size: 21,
              ),
              onTap: () => throttle(() => Navigator.of(context).pop()),
            ),
            PlaceHolder(size: 20),
          ],
        ),
        PlaceHolder(
          axis: Axis.vertical,
          size: 20,
        ),
        Expanded(
            child: GridView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Spacer(),
                        generateImage(
                            list[index].imageType, list[index].imagePath),
                        PlaceHolder(
                          axis: Axis.vertical,
                          size: 8,
                        ),
                        Text(
                          list[index].text,
                          style: labelTextStyle,
                        ),
                        Spacer()
                      ],
                    ),
                    onTap: () {
                      onClickAction?.call(list[index].text);
                      Navigator.of(context).pop();
                    },
                  );
                })),
      ]),
    );
  }

  Widget generateImage(ImageType imageType, String path) {
    if (imageType == ImageType.NETWORK) {
      return CachedNetworkImage(
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
              ),
          imageUrl: path);
    } else {
      return CircleAvatar(
        backgroundImage: AssetImage(path),
      );
    }
  }
}
