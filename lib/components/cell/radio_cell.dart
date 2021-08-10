
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/constant/image_constant.dart';
import 'package:flutter_component/flutter_component.dart';

class RadioCell extends StatefulWidget {

  final String label;

  final TextStyle labelTextStyle;

  late final String path;

  late final double imageWidth;

  late final double imageHeight;

  late final ImageType imageType;

  late final double radius;

  late final Function(String value)? onClickAction;

  late final String value;

  late final String groupValue;

  late final Color selectedColor;

  late final Color bgColor;

  RadioCell(this.path, this.value, this.groupValue,this.selectedColor, {this.bgColor = Colors.white, this.label = '', this.labelTextStyle = const TextStyle(), this.imageWidth = 32,
      this.imageHeight = 32, this.imageType = ImageType.NETWORK, this.radius = 4, this.onClickAction});

  @override
  State<StatefulWidget> createState() => _RadioCellState();

}

class _RadioCellState extends State<RadioCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 10),
        color: widget.bgColor,
        child: Row(
          children: [
            generateImage(),
            PlaceHolder(size: 14),
            Text(widget.label, style: widget.labelTextStyle.copyWith(color: widget.value == widget.groupValue ? widget.selectedColor:widget.labelTextStyle.color),),
            Spacer(),
            Radio(value: widget.value, groupValue: widget.groupValue, onChanged: (v){
              widget.onClickAction?.call(widget.value);
            }),
          ],
        ),
      ),
      onTap: () => widget.onClickAction?.call(widget.value),
    );
  }

  Widget generateImage() {
    if (widget.imageType == ImageType.NETWORK) {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) =>
            Container(
              width: widget.imageWidth,
              height: widget.imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
        imageUrl: widget.path,
      );
    } else {
      return Container(
          width: widget.imageWidth,
          height: widget.imageHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            image: DecorationImage(image: AssetImage(widget.path), fit: BoxFit.cover),
          )
      );
    }
  }
}