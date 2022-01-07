import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/dividing_line.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class OrderCard extends StatelessWidget {
  final double radius;

  final EdgeInsetsGeometry margin;

  final double elevation;

  final VoidCallback? onClickAction;

  final String title;

  final TextStyle titleStyle;

  final String stateText;

  final TextStyle stateStyle;

  final Widget? child;

  final List<Widget> extraButton;

  final Color lineBg;

  const OrderCard(this.title,
      {this.stateText = '',
      this.titleStyle = const TextStyle(),
      this.stateStyle = const TextStyle(),
      this.radius = 4,
      this.margin = const EdgeInsets.only(left: 10, right: 10, top: 5),
      this.elevation = 1,
      this.onClickAction,
      this.child,
      this.extraButton = const [],
      this.lineBg = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        margin: margin,
        elevation: elevation,
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.archivebox),
                  const PlaceHolder(size: 8),
                  Text(
                    title,
                    style: titleStyle,
                  ),
                  const Spacer(),
                  Text(
                    stateText,
                    style: stateStyle,
                  )
                ],
              ),
              const PlaceHolder(
                size: 5,
                axis: Axis.vertical,
              ),
              DividingLine(
                lineBg,
                margin: EdgeInsets.zero,
                height: 0.3,
              ),
              child ?? Container(),
              extraButton.isNotEmpty
                  ? PlaceHolder(
                      size: 5,
                      axis: Axis.vertical,
                    )
                  : Container(),
              extraButton.isNotEmpty
                  ? DividingLine(
                      lineBg,
                      margin: EdgeInsets.zero,
                      height: 2,
                    )
                  : Container(),
              extraButton.isNotEmpty
                  ? const PlaceHolder(
                      size: 5,
                      axis: Axis.vertical,
                    )
                  : Container(),
              _buildButtons()
            ],
          ),
        ),
      ),
      onTap: () => onClickAction?.call(),
    );
  }

  Widget _buildButtons() {
    Widget container = Container();
    if (extraButton.isNotEmpty) {
      container = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: extraButton.map((e) {
          return Container(
            margin: const EdgeInsets.only(left: 10),
            child: e,
          );
        }).toList(),
      );
    }
    return container;
  }
}
