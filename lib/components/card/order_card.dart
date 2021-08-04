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

  OrderCard(this.title,
      {this.stateText = '',
      this.titleStyle = const TextStyle(),
      this.stateStyle = const TextStyle(),
      this.radius = 4,
      this.margin = const EdgeInsets.only(left: 10, right: 10, top: 5),
      this.elevation = 1,
      this.onClickAction,
      this.child,
      this.extraButton = const []});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
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
                  Icon(CupertinoIcons.archivebox),
                  PlaceHolder(size: 8),
                  Text(title),
                  Spacer(),
                  Text(stateText)
                ],
              ),
              PlaceHolder(
                size: 5,
                axis: Axis.vertical,
              ),
              DividingLine(
                Colors.grey,
                margin: EdgeInsets.zero,
                height: 0.3,
              ),
              PlaceHolder(
                size: 5,
                axis: Axis.vertical,
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
                      Colors.grey,
                      margin: EdgeInsets.zero,
                      height: 0.3,
                    )
                  : Container(),
              extraButton.isNotEmpty
                  ? PlaceHolder(
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
            margin: EdgeInsets.only(left: 10),
            child: e,
          );
        }).toList(),
      );
    }
    return container;
  }
}
