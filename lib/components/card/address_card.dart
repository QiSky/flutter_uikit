import 'package:flutter/material.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class AddressCard extends StatelessWidget {
  final String text;

  final Widget? tagChild;

  final TextStyle textStyle;

  final String subText;

  final TextStyle subTextStyle;

  final Widget? rightIcon;

  final double height;

  final double? radius;

  final VoidCallback? onClickAction;

  final double elevation;

  final EdgeInsetsGeometry margin;

  const AddressCard(this.text,
      {this.tagChild,
      this.elevation = 1,
      this.radius,
      this.textStyle = const TextStyle(),
      this.subText = '',
      this.subTextStyle = const TextStyle(),
      this.rightIcon,
      this.height = 70,
      this.margin = const EdgeInsets.only(left: 10, right: 10),
      this.onClickAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(radius ?? height / 2))),
        margin: margin,
        elevation: elevation,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        tagChild ?? Container(),
                        tagChild == null
                            ? Container()
                            : const PlaceHolder(
                                size: 4,
                              ),
                        Text(text, style: textStyle)
                      ],
                    ),
                    const PlaceHolder(
                      axis: Axis.vertical,
                      size: 5,
                    ),
                    Text(subText, style: subTextStyle),
                    const Spacer(),
                  ],
                )),
                rightIcon ?? Container()
              ],
            ),
          ),
        ),
      ),
      onTap: () => onClickAction?.call(),
    );
  }
}
