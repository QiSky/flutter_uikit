import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/components/state/base_state.dart';

class OptionEntry {
  String name;

  dynamic extraData;

  OptionEntry(this.name, {this.extraData});
}

class OptionBottomSheet extends StatefulWidget {
  final String title;

  final List<OptionEntry> dataSourceList;

  String? selectedText;

  final Function(OptionEntry data)? selectAction;

  Color inactiveColor;

  Color activeColor;

  OptionBottomSheet(this.title, this.dataSourceList, this.activeColor,
      {this.selectedText = "",
      this.selectAction,
      this.inactiveColor = const Color(0xFFF6F8FB)});

  @override
  State<StatefulWidget> createState() => _OptionBottomSheetState();
}

class _OptionBottomSheetState extends BaseState<OptionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        PlaceHolder(
          axis: Axis.vertical,
          size: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlaceHolder(size: 20),
            Text(widget.title,
                style: TextStyle(fontSize: 16, color: Color(0xFF18191A), fontWeight: FontWeight.w600)),
            Spacer(),
            GestureDetector(
              child: Icon(CupertinoIcons.clear),
              onTap: () => Navigator.of(context).pop(),
            ),
            PlaceHolder(size: 20),
          ],
        ),
        PlaceHolder(
          axis: Axis.vertical,
          size: 25,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.dataSourceList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: _getItem(index),
                  onTap: () {
                    setState(() {
                      widget.selectedText = widget.dataSourceList[index].name;
                    });
                    Future.delayed(Duration(microseconds: 300), () {
                      widget.selectAction?.call(widget.dataSourceList[index]);
                      Navigator.of(context).pop();
                    });
                  });
            })
      ]),
    );
  }

  Widget _getItem(int index) {
    return Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: widget.dataSourceList[index].name == widget.selectedText
                  ? widget.activeColor
                  : widget.inactiveColor,
              border: Border.all(
                  color: Color(0xFFD6DCE8),
                  width: 1,
                  style: BorderStyle.solid)),
          child: Center(
              child: Text(widget.dataSourceList[index].name,
                  style: TextStyle(
                      color: widget.dataSourceList[index].name ==
                              widget.selectedText
                          ? Colors.white
                          : Colors.black,
                      fontSize: 15, fontWeight: FontWeight.w600))),
        ));
  }
}
