
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/constant/image_constant.dart';

class CircleImage extends StatelessWidget {

  late final String path;

  late final double imageWidth;

  late final double imageHeight;

  late final ImageType imageType;

  late final Border border;

  CircleImage(this.path, {this.border = const Border(), this.imageWidth = 58, this.imageHeight = 58, this.imageType = ImageType.NETWORK});

  @override
  Widget build(BuildContext context) {
    return generateImage();
  }

  Widget generateImage() {
    if(imageType == ImageType.NETWORK) {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          width: imageWidth,
          height: imageHeight,
          decoration: BoxDecoration(
            border: border,
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        imageUrl: path
      );
    } else {
      return Container(
        width: imageWidth,
        height: imageHeight,
        decoration: BoxDecoration(
          border: border,
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        )
      );
    }
  }
}