import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/components/state/base_state.dart';

class OptionEntry {
  int? id;

  String name;

  dynamic extraData;

  OptionEntry(this.name, {this.id, this.extraData});
}

class OptionBottomSheet extends StatefulWidget {
  final String title;

  final List<OptionEntry> dataSourceList;

  final String? selectedText;

  final Function(OptionEntry data)? selectAction;

  final Color inactiveColor;

  final Color activeColor;

  final double height;

  final int? selectedIndex;

  final Color? inactiveTextColor;

  final Color? activeTextColor;

  final double radius;

  late final Color bgColor;
  OptionBottomSheet(this.title, this.dataSourceList, this.activeColor,
      {this.selectedText = "",
      this.selectedIndex,
      this.height = 400,
      this.selectAction,
      this.activeTextColor = Colors.white,
      this.inactiveTextColor = Colors.black,
      this.radius = 24,
      this.bgColor = Colors.white,
      this.inactiveColor = const Color(0xFFF6F8FB)});

  @override
  State<StatefulWidget> createState() => _OptionBottomSheetState();
}

class _OptionBottomSheetState extends BaseState<OptionBottomSheet> {
  int? _selectedIndex;

  String? _selectedText;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    _selectedText = widget.selectedText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: widget.height),
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.radius), topRight: Radius.circular(widget.radius)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        PlaceHolder(
          axis: Axis.vertical,
          size: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlaceHolder(size: 20),
            Text(widget.title,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF18191A),
                    fontWeight: FontWeight.w600)),
            Spacer(),
            GestureDetector(
              child: Icon(CupertinoIcons.clear, size: 21),
              onTap: () => Navigator.of(context).pop(),
            ),
            PlaceHolder(size: 20),
          ],
        ),
        PlaceHolder(
          axis: Axis.vertical,
          size: 20,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.dataSourceList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: _getItem(index),
                  onTap: () {
                    setState(() {
                      _selectedIndex = widget.dataSourceList[index].id;
                      _selectedText = widget.dataSourceList[index].name;
                    });
                    Future.delayed(Duration(microseconds: 300), () {
                      widget.selectAction?.call(widget.dataSourceList[index]);
                      Navigator.of(context).pop();
                    });
                  });
            }),
        PlaceHolder(
          axis: Axis.vertical,
          size: 20,
        ),
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
              color: widget.dataSourceList[index].id == _selectedIndex ||
                      widget.dataSourceList[index].name == _selectedText
                  ? widget.activeColor
                  : widget.inactiveColor,
              border: Border.all(
                  color: Color(0xFFD6DCE8),
                  width: 1,
                  style: BorderStyle.solid)),
          child: Center(
              child: Text(widget.dataSourceList[index].name,
                  style: TextStyle(
                      color: widget.dataSourceList[index].id ==
                                  _selectedIndex ||
                              widget.dataSourceList[index].name == _selectedText
                          ? widget.activeTextColor
                          : widget.inactiveTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600))),
        ));
  }
}
