import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class BorderSearchBar extends StatefulWidget {
  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final Function? onClickAction;

  final Color? hintColor;

  final double? radius;

  final Color? borderColor;

  final EdgeInsets? buttonMargin;

  final TextStyle? buttonTextStyle;

  final double? opacity;

  const BorderSearchBar(
      {this.hintColor = Colors.grey,
      this.borderColor = Colors.blue,
      this.buttonMargin = const EdgeInsets.all(1),
      this.margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      this.padding = const EdgeInsets.symmetric(vertical: 2),
      this.onClickAction,
      this.buttonTextStyle = const TextStyle(),
      this.radius = 12,
      this.opacity = 0.5});

  @override
  State<StatefulWidget> createState() => _BorderSearchBarState();
}

class _BorderSearchBarState extends State<BorderSearchBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: widget.padding,
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius!),
            border: Border.all(width: 2, color: widget.borderColor!),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              const PlaceHolder(
                size: 8,
              ),
              Icon(
                CupertinoIcons.search,
                size: 22,
                color: widget.hintColor,
              ),
              const PlaceHolder(
                size: 8,
              ),
              Expanded(
                  child: Text(
                '搜索',
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              )),
              Container(
                  margin: widget.buttonMargin,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.radius!),
                      gradient: LinearGradient(colors: [
                        widget.borderColor!.withOpacity(widget.opacity!),
                        widget.borderColor!,
                      ])),
                  child: Center(
                      child: Text(
                    '搜索',
                    style: widget.buttonTextStyle,
                  ))),
            ],
          )),
      onTap: () => widget.onClickAction?.call(),
    );
  }
}
