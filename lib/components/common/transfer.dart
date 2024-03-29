import 'package:flutter/material.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/components/text/overflow_text.dart';

import '../text/active_text.dart';

///
/// * @ProjectName: flutter_uikit
/// * @Author: qifanxin
/// * @CreateDate: 2022/8/31 17:32
/// * @Description: 文件说明
///

class TransferWidget<T extends AbstractTransferData> extends StatefulWidget {
  final List<T> leftData;

  final List<T> rightData;

  final double? maxHeight;

  final Color activeColor;

  final Color inactiveColor;

  final EdgeInsets padding;

  final String? leftTitle;

  final String? rightTitle;

  final Function(bool isChanged)? onDateChanged;

  const TransferWidget(
      {required this.leftData,
      required this.rightData,
      this.maxHeight = 300,
      required this.activeColor,
      required this.inactiveColor,
      this.padding = EdgeInsets.zero,
      this.leftTitle = '',
      this.rightTitle = '',
      this.onDateChanged});

  @override
  State<StatefulWidget> createState() => _TransferWidgetState();
}

class _TransferWidgetState extends State<TransferWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      constraints: BoxConstraints(maxHeight: widget.maxHeight ?? 0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(width: 0.4, color: Colors.grey)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                          child: OverflowText(
                        widget.leftTitle ?? '',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                      const PlaceHolder(
                        size: 5,
                      ),
                      Text(
                          "${widget.leftData.where((element) => element.isActive == true).toList().length}/${widget.leftData.length}")
                    ],
                  ),
                  color: Colors.grey.withOpacity(0.6),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.leftData.length,
                      itemBuilder: (_, index) {
                        return ActiveText(
                          isActive: widget.leftData[index].isActive ?? false,
                          text: widget.leftData[index].toName(),
                          inactiveColor: widget.inactiveColor,
                          activeColor: widget.activeColor,
                          onActiveChangeAction: (isActive) {
                            widget.leftData[index].isActive = isActive;
                            setState(() {});
                          },
                        );
                      }),
                ))
              ],
            ),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    var transferData = widget.rightData
                        .where((element) => element.isActive == true)
                        .toList();
                    transferData.forEach((element) {
                      widget.rightData.remove(element);
                      element.isActive = false;
                    });
                    widget.leftData.insertAll(0, transferData);
                    setState(() {});
                    widget.onDateChanged?.call(true);
                  },
                  icon: Icon(Icons.keyboard_arrow_left)),
              const PlaceHolder(
                axis: Axis.vertical,
                size: 10,
              ),
              IconButton(
                  onPressed: () {
                    var transferData = widget.leftData
                        .where((element) => element.isActive == true)
                        .toList();
                    transferData.forEach((element) {
                      widget.leftData.remove(element);
                      element.isActive = false;
                    });
                    widget.rightData.insertAll(0, transferData);
                    setState(() {});
                    widget.onDateChanged?.call(true);
                  },
                  icon: Icon(Icons.keyboard_arrow_right))
            ],
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(width: 0.4, color: Colors.grey)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                          child: OverflowText(
                        widget.rightTitle ?? '',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                      const PlaceHolder(
                        size: 5,
                      ),
                      Text(
                          "${widget.rightData.where((element) => element.isActive == true).toList().length}/${widget.rightData.length}")
                    ],
                  ),
                  color: Colors.grey.withOpacity(0.6),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.rightData.length,
                      itemBuilder: (_, index) {
                        return ActiveText(
                          isActive: widget.rightData[index].isActive ?? false,
                          text: widget.rightData[index].toName(),
                          inactiveColor: widget.inactiveColor,
                          activeColor: widget.activeColor,
                          onActiveChangeAction: (isActive) {
                            widget.rightData[index].isActive = isActive;
                            setState(() {});
                          },
                        );
                      }),
                ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}

abstract class AbstractTransferData {
  bool? isActive;

  String toName();
}
