import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeStatus {
  String bottomText;

  Widget? topWidget;

  TimeStatus(this.bottomText, {this.topWidget});
}

class TimeStatusLine extends StatefulWidget {
  late final List<TimeStatus> timeStatusList;

  late final int index;

  late final Color bgColor;

  late final double indicatorSize;

  late final double lineWidth;

  late final double lineThick;

  late final Color lineColor;
  
  TimeStatusLine(this.timeStatusList, this.index, this.bgColor, {this.indicatorSize = 24, this.lineWidth = 80, this.lineThick = 2, this.lineColor = const Color(0xFFEDEDED)});

  @override
  State<StatefulWidget> createState() => _TimeStatusLineState();
}

class _TimeStatusLineState extends State<TimeStatusLine> {
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: getTimeLines(),
    );
  }

  List<Widget> getTimeLines() {
    List<Widget> list = [];
    for (var i = 0; i < widget.timeStatusList.length; i++) {
      if (i == 0) {
        list.add(Container(
            width: widget.lineWidth,
            child: TimelineTile(
                isFirst: true,
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.center,
                afterLineStyle: i == widget.index
                    ? LineStyle(color: widget.lineColor, thickness: widget.lineThick)
                    : LineStyle(color: widget.bgColor, thickness: widget.lineThick),
                endChild: getBottomText(widget.timeStatusList[i].bottomText, fontColor: widget.bgColor),
                startChild: widget.timeStatusList[i].topWidget??Container(),
                indicatorStyle: i == widget.index
                    ? getWaiting()
                    : getMark())));
      } else if (i == widget.timeStatusList.length - 1) {
        list.add(Container(
            width: widget.lineWidth,
            child: TimelineTile(
                isLast: true,
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.center,
                beforeLineStyle: i == widget.index
                    ? LineStyle(color: widget.bgColor, thickness: widget.lineThick)
                    : LineStyle(color: widget.lineColor, thickness: widget.lineThick),
                endChild: getBottomText(widget.timeStatusList[i].bottomText, fontColor: i == widget.index ? widget.bgColor: Colors.black),
                indicatorStyle: i == widget.index
                    ? getMark()
                    : getReady())));
      } else {
        if (i < widget.index) {
          list.add(Container(
              width: widget.lineWidth,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(color: widget.bgColor, thickness: widget.lineThick),
                  beforeLineStyle: LineStyle(color: widget.bgColor, thickness: widget.lineThick),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText, fontColor: widget.bgColor),
                  indicatorStyle: getMark())));
        } else if (i > widget.index) {
          list.add(Container(
              width: widget.lineWidth,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(color: widget.lineColor, thickness: widget.lineThick),
                  beforeLineStyle: LineStyle(color: widget.lineColor, thickness: widget.lineThick),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText),
                  indicatorStyle: getReady())));
        } else {
          list.add(Container(
              width: widget.lineWidth,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(color: widget.lineColor, thickness: widget.lineThick),
                  beforeLineStyle: LineStyle(color: widget.bgColor, thickness: widget.lineThick),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText, fontColor: widget.bgColor),
                  indicatorStyle: getWaiting())));
        }
      }
    }
    return list;
  }

  IndicatorStyle getWaiting() {
    return IndicatorStyle(
        width: widget.indicatorSize,
        height: widget.indicatorSize,
        indicator: Container(
          width: widget.indicatorSize,
          height: widget.indicatorSize,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: widget.bgColor),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        ));
  }

  IndicatorStyle getMark() {
    return IndicatorStyle(
        width: widget.indicatorSize,
        height: widget.indicatorSize,
        indicator: Container(
          width: widget.indicatorSize,
          height: widget.indicatorSize,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: widget.bgColor),
          child: Center(child: Icon(CupertinoIcons.checkmark_alt , size: 10, color: Colors.white,)),
        ));
  }

  IndicatorStyle getReady() {
    return IndicatorStyle(
        width: widget.indicatorSize,
        height: widget.indicatorSize,
        indicator: Container(
          width: widget.indicatorSize,
          height: widget.indicatorSize,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: widget.lineColor),
          )
        );
  }

  Widget getBottomText(String text, {Color fontColor = Colors.black}) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 10),
      child: Text(text, style: TextStyle(color: fontColor, fontSize: 15, fontWeight: FontWeight.w500),),
    );
  }
}
