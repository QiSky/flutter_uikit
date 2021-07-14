import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/dividing_line.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class ListItem extends StatefulWidget {
  final double itemHeight;

  final String rightText;

  final TextStyle rightTextStyle;

  final String leftText;

  final TextStyle leftTextStyle;

  final Widget? leftWidget;

  final Widget? rightWidget;

  final double leftPadding;

  final double rightPadding;

  final VoidCallback? onClickAction;

  final Color bgColor;

  final bool isTopLineShow;

  final bool isBottomLineShow;

  final bool isTopLineFull;

  final bool isBottomLineFull;

  ListItem(
      {
        this.leftWidget,
        this.itemHeight = 56,
        this.leftPadding = 10,
        this.rightPadding = 10,
        this.isTopLineShow = true,
        this.isBottomLineShow = true,
        this.isTopLineFull = true,
        this.isBottomLineFull = true,
        this.onClickAction,
        this.leftText = "",
        this.leftTextStyle = const TextStyle(),
        this.rightText = "",
        this.rightTextStyle = const TextStyle(),
        this.bgColor = Colors.white,
        this.rightWidget});

  @override
  State<StatefulWidget> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      color: widget.bgColor,
      child: InkWell(
        child: Container(
          height: widget.itemHeight,
          width: double.infinity,
          child: Column(
            children: [
              widget.isTopLineShow ? DividingLine(Colors.grey, height: 0.2, margin: widget.isTopLineFull?EdgeInsets.zero:EdgeInsets.only(left: 30),) : Container(),
              Spacer(),
              Row(mainAxisSize: MainAxisSize.max,crossAxisAlignment: CrossAxisAlignment.center, children: [
                PlaceHolder(size: widget.leftPadding),
                widget.leftWidget?? Container(),
                PlaceHolder(size: widget.leftWidget == null? 0:8),
                Text(widget.leftText, style: widget.leftTextStyle, overflow: TextOverflow.ellipsis,),
                Spacer(),
                Text(widget.rightText, style: widget.rightTextStyle),
                PlaceHolder(size: 6),
                widget.rightWidget?? Icon(CupertinoIcons.chevron_right, size: 22, color: Colors.grey,),
                PlaceHolder(size: widget.rightPadding),
              ]),
              Spacer(),
              widget.isBottomLineShow ? DividingLine(Colors.grey, height: 0.2, margin: widget.isTopLineFull?EdgeInsets.zero:EdgeInsets.only(left: 30)) : Container(),
            ],
          ),
        ),
        onTap: () => widget.onClickAction?.call(),
      ),
    );
  }
}
