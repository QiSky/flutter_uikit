import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/constant/image_constant.dart';

class LabelProductCard extends StatelessWidget {
  final double radius;

  final double imageToBottom;

  final double imageToRight;

  final String path;

  final String? errorPath;

  final BoxFit imageFit;

  final ImageType imageType;

  final Color labelColor;

  final String labelText;

  final TextStyle labelStyle;

  final double? imageHeight;

  final double? imageWidth;

  final EdgeInsetsGeometry padding;

  final dynamic? extraData;

  final Function(dynamic? extraData)? onClickAction;

  LabelProductCard(this.labelColor, this.labelText, this.path,
      {this.radius = 10,
      this.padding = EdgeInsets.zero,
      this.imageWidth,
      this.imageHeight,
      this.imageToBottom = 16,
      this.imageToRight = 16,
      this.labelStyle = const TextStyle(),
      this.errorPath,
      this.imageFit = BoxFit.contain,
      this.imageType = ImageType.LOCAL,
      this.extraData,
      this.onClickAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: AspectRatio(
          aspectRatio: 1,
          child: GestureDetector(
            onTap: () => onClickAction?.call(extraData),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: Stack(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(9, 6, 9, 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius),
                              bottomRight: Radius.circular(radius)),
                          color: labelColor),
                      child: Text(labelText, style: labelStyle),
                    ),
                  ),
                  Positioned(
                      bottom: imageToBottom,
                      right: imageToRight,
                      child: generateImage())
                ])),
          )),
    );
  }

  Widget generateImage() {
    if (imageType == ImageType.LOCAL) {
      return Image.asset(
        path,
        fit: imageFit,
        width: imageWidth,
        height: imageHeight,
      );
    } else {
      return CachedNetworkImage(
          width: imageWidth,
          height: imageHeight,
          imageUrl: path,
          fit: imageFit,
          errorWidget: (context, url, error) {
            return Image.asset(errorPath!, fit: imageFit);
          });
    }
  }
}
