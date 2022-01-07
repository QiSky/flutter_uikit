import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateTimePickerItem extends StatefulWidget {
  final List<int> timeRangeList;

  final Function(int data) selectedCallBack;

  final String unit;

  int? defaultValue;

  DateTimePickerItem(this.timeRangeList, this.selectedCallBack, this.unit,
      {this.defaultValue});

  @override
  State<StatefulWidget> createState() => _DateTimePickerItemState();
}

class _DateTimePickerItemState extends State<DateTimePickerItem> {
  int currentIndex = 0;

  FixedExtentScrollController? _controller;

  @override
  void initState() {
    if (widget.defaultValue != null) {
      if (!widget.timeRangeList.contains(widget.defaultValue!)) {
        currentIndex = widget.timeRangeList.length - 1;
      } else {
        currentIndex = widget.timeRangeList.indexOf(widget.defaultValue!);
      }
    }
    if (widget.defaultValue != null) {
      _controller = FixedExtentScrollController(
          initialItem: !widget.timeRangeList.contains(widget.defaultValue!)
              ? widget.timeRangeList.length - 1
              : widget.timeRangeList.indexOf(widget.defaultValue!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex > widget.timeRangeList.length - 1) {
      currentIndex = widget.timeRangeList.length - 1;
    }
    return Expanded(
        child: CupertinoPicker.builder(
      useMagnifier: true,
      diameterRatio: 20,
      backgroundColor: Colors.white,
      scrollController: _controller,
      selectionOverlay: null,
      onSelectedItemChanged: (int value) {
        widget.selectedCallBack.call(widget.timeRangeList[value]);
        setState(() {
          currentIndex = value;
        });
      },
      itemExtent: 75,
      childCount: widget.timeRangeList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '${widget.timeRangeList[index]}${widget.unit}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize:
                    widget.timeRangeList.indexOf(widget.timeRangeList[index]) ==
                            currentIndex
                        ? 18
                        : 16),
          ),
        );
      },
    ));
  }
}
