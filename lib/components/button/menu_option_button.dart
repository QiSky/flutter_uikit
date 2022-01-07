import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/constant/image_constant.dart';

class MenuOptionButton extends StatelessWidget {
  final String text;

  final String path;

  final TextStyle textStyle;

  final Color color;

  final ImageType imageType;

  final VoidCallback? onClickAction;

  const MenuOptionButton(this.text, this.path,
      {this.textStyle = const TextStyle(),
      this.color = const Color(0xFFF3F4F8),
      this.imageType = ImageType.LOCAL,
      this.onClickAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: generateImage(),
              ),
            ),
            const PlaceHolder(
              axis: Axis.vertical,
              size: 2,
            ),
            Text(text, style: textStyle)
          ],
        ),
      ),
      onTap: () => onClickAction?.call(),
    );
  }

  Widget generateImage() {
    if (imageType == ImageType.NETWORK) {
      return CachedNetworkImage(fit: BoxFit.cover, imageUrl: path);
    } else {
      return Image.asset(
        path,
        fit: BoxFit.cover,
      );
    }
  }
}
