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
  
  TimeStatusLine(this.timeStatusList, this.index, this.bgColor);

  @override
  State<StatefulWidget> createState() => _TimeStatusLineState();
}

class _TimeStatusLineState extends State<TimeStatusLine> {
  
  double width = 75;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: getTimeLines(),
      ),
    );
  }

  List<Widget> getTimeLines() {
    List<Widget> list = [];
    for (var i = 0; i < widget.timeStatusList.length; i++) {
      if (i == 0) {
        list.add(Container(
            width: width,
            child: TimelineTile(
                isFirst: true,
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.center,
                afterLineStyle: i == widget.index
                    ? LineStyle(color: Colors.grey[400]!)
                    : LineStyle(color: Colors.white),
                endChild: getBottomText(widget.timeStatusList[i].bottomText, fontColor: i == widget.index ? widget.bgColor: Colors.black),
                startChild: widget.timeStatusList[i].topWidget??Container(),
                indicatorStyle: i == widget.index
                    ? getWaiting()
                    : getMark())));
      } else if (i == widget.timeStatusList.length - 1) {
        list.add(Container(
            width: width,
            child: TimelineTile(
                isLast: true,
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.center,
                beforeLineStyle: i == widget.index
                    ? LineStyle(color: Colors.white)
                    : LineStyle(color: Colors.grey[400]!),
                endChild: getBottomText(widget.timeStatusList[i].bottomText, fontColor: i == widget.index ? widget.bgColor: Colors.black),
                startChild: widget.timeStatusList[i].topWidget??Container(),
                indicatorStyle: i == widget.index
                    ? getMark()
                    : getReady())));
      } else {
        if (i < widget.index) {
          list.add(Container(
              width: width,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(color: Colors.white),
                  beforeLineStyle: LineStyle(color: Colors.white),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText),
                  startChild: widget.timeStatusList[i].topWidget??Container(),
                  indicatorStyle: getMark())));
        } else if (i > widget.index) {
          list.add(Container(
              width: width,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(color: Colors.grey[400]!),
                  beforeLineStyle: LineStyle(color: Colors.grey[400]!),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText),
                  startChild: widget.timeStatusList[i].topWidget??Container(),
                  indicatorStyle: getReady())));
        } else {
          list.add(Container(
              width: width,
              child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  afterLineStyle: LineStyle(color: Colors.grey[400]!),
                  beforeLineStyle: LineStyle(color: Colors.white),
                  endChild: getBottomText(widget.timeStatusList[i].bottomText, fontColor: widget.bgColor),
                  startChild: widget.timeStatusList[i].topWidget??Container(),
                  indicatorStyle: getWaiting())));
        }
      }
    }
    return list;
  }

  IndicatorStyle getWaiting() {
    return IndicatorStyle(
        width: 32,
        height: 32,
        indicator: Container(
          width: 32,
          height: 32,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: widget.bgColor),
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Colors.white,
          ),
        ));
  }

  IndicatorStyle getMark() {
    return IndicatorStyle(
        width: 32,
        height: 32,
        indicator: Container(
          width: 32,
          height: 32,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.white),
          child: Center(child: Icon(CupertinoIcons.checkmark_alt , size: 19)),
        ));
  }

  IndicatorStyle getReady() {
    return IndicatorStyle(
        width: 32,
        height: 32,
        indicator: Container(
          width: 32,
          height: 32,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.grey[400]!),
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
