import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeStatus {
  final String bottomText;

  final Widget? topWidget;

  TimeStatus(this.bottomText, {this.topWidget});
}

class TimeStatusLine extends StatefulWidget {
  final List<TimeStatus> timeStatusList;

  final int index;

  final Color bgColor;

  final double indicatorSize;

  final double lineWidth;

  final double lineThick;

  final Color lineColor;

  const TimeStatusLine(this.timeStatusList, this.index, this.bgColor,
      {this.indicatorSize = 24,
      this.lineWidth = 80,
      this.lineThick = 2,
      this.lineColor = const Color(0xFFEDEDED)});

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
                    ? LineStyle(
                        color: widget.lineColor, thickness: widget.lineThick)
                    : LineStyle(
                        color: widget.bgColor, thickness: widget.lineThick),
                endChild: getBottomText(widget.timeStatusList[i].bottomText,
                    fontColor: widget.bgColor),
                startChild: widget.timeStatusList[i].topWidget ??
                    PlaceHolder(axis: Axis.vertical, size: 1),
                indicatorStyle: i == widget.index ? getWaiting() : getMark())));
      } else if (i == widget.timeStatusList.length - 1) {
        list.add(Container(
            width: widget.lineWidth,
            child: TimelineTile(
                isLast: true,
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.center,
                beforeLineStyle: i == widget.index
                    ? LineStyle(
                        color: widget.bgColor, thickness: widget.lineThick)
                    : LineStyle(
                        color: widget.lineColor, thickness: widget.lineThick),
                endChild: getBottomText(widget.timeStatusList[i].bottomText,
                    fontColor:
                        i == widget.index ? widget.bgColor : Color(0xFFBDBDBD)),
                startChild: widget.timeStatusList[i].topWidget ??
                    PlaceHolder(axis: Axis.vertical, size: 1),
                indicatorStyle: i == widget.index ? getMark() : getReady())));
      } else {
        if (i < widget.index) {
          list.add(Container(
              width: widget.lineWidth,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(
                      color: widget.bgColor, thickness: widget.lineThick),
                  beforeLineStyle: LineStyle(
                      color: widget.bgColor, thickness: widget.lineThick),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText,
                      fontColor: widget.bgColor),
                  startChild: widget.timeStatusList[i].topWidget ??
                      PlaceHolder(axis: Axis.vertical, size: 1),
                  indicatorStyle: getMark())));
        } else if (i > widget.index) {
          list.add(Container(
              width: widget.lineWidth,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(
                      color: widget.lineColor, thickness: widget.lineThick),
                  beforeLineStyle: LineStyle(
                      color: widget.lineColor, thickness: widget.lineThick),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText),
                  startChild: widget.timeStatusList[i].topWidget ??
                      PlaceHolder(axis: Axis.vertical, size: 1),
                  indicatorStyle: getReady())));
        } else {
          list.add(Container(
              width: widget.lineWidth,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(
                      color: widget.lineColor, thickness: widget.lineThick),
                  beforeLineStyle: LineStyle(
                      color: widget.bgColor, thickness: widget.lineThick),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText,
                      fontColor: widget.bgColor),
                  startChild: widget.timeStatusList[i].topWidget ??
                      PlaceHolder(axis: Axis.vertical, size: 1),
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
          padding: const EdgeInsets.all(6),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: widget.bgColor),
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
          padding: const EdgeInsets.all(8),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: widget.bgColor),
          child: Center(
              child: const Icon(
            CupertinoIcons.checkmark_alt,
            size: 10,
            color: Colors.white,
          )),
        ));
  }

  IndicatorStyle getReady() {
    return IndicatorStyle(
        width: widget.indicatorSize,
        height: widget.indicatorSize,
        indicator: Container(
          width: widget.indicatorSize,
          height: widget.indicatorSize,
          padding: const EdgeInsets.all(8),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: widget.lineColor),
        ));
  }

  Widget getBottomText(String text,
      {Color fontColor = const Color(0xFFBDBDBD)}) {
    return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 10),
        child: Text(text, style: TextStyle(color: fontColor, fontSize: 14)));
  }
}
