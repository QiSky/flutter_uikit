import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/constant/image_constant.dart';

class CircleImage extends StatelessWidget {
  final String path;

  final double imageWidth;

  final double imageHeight;

  final ImageType imageType;

  final Border border;

  final Widget Function()? errorCallBack;

  final Widget Function()? placeHolderCallBack;

  const CircleImage(this.path,
      {this.border = const Border(),
      this.imageWidth = 58,
      this.imageHeight = 58,
      this.imageType = ImageType.NETWORK,
      this.errorCallBack,
      this.placeHolderCallBack});

  @override
  Widget build(BuildContext context) {
    return generateImage();
  }

  Widget generateImage() {
    if (imageType == ImageType.NETWORK) {
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
        imageUrl: path,
        errorWidget: (context, url, error) {
          if (errorCallBack != null) {
            return errorCallBack!();
          } else {
            return Container();
          }
        },
        placeholder: (context, url) {
          if (placeHolderCallBack != null) {
            return placeHolderCallBack!();
          } else {
            return Container();
          }
        },
      );
    } else {
      return Container(
          width: imageWidth,
          height: imageHeight,
          decoration: BoxDecoration(
            border: border,
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
          ));
    }
  }
}
