import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/label_tag.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class AddressEditCard extends StatefulWidget {
  final double latitude;

  final double longitude;

  final String name;

  final int sex;

  final String telephone;

  final String label;

  final String tag;

  final Color tagBgColor;

  final EdgeInsets padding;

  AddressEditCard(
      {this.latitude = 0.0,
      this.longitude = 0.0,
      this.name = '',
      this.sex = -1,
      this.telephone = '',
      this.label = '',
      this.tag = '',
      this.tagBgColor = Colors.blue,
      this.padding = const EdgeInsets.only(left: 15, right: 15)});

  @override
  State<StatefulWidget> createState() => _AddressEditCardState();
}

class _AddressEditCardState extends State<AddressEditCard> {
  late int _sexState;

  late String selectedTag;

  @override
  void initState() {
    _sexState = widget.sex;
    selectedTag = widget.tag;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: widget.padding,
          width: double.infinity,
          child: Card(
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('123'),
                PlaceHolder(
                  axis: Axis.vertical,
                  size: 5,
                ),
                Text('123'),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: widget.padding,
          child: Card(
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PlaceHolder(axis: Axis.vertical, size: 5),
                Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 15),
                        constraints: BoxConstraints.expand(width: 70),
                        child: Text(
                          '门牌号',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                          child: CupertinoTextField(
                        placeholder: '门牌号',
                        decoration: BoxDecoration(
                            border: Border.all(width: 0, color: Colors.white)),
                      ))
                    ],
                  ),
                ),
                PlaceHolder(axis: Axis.vertical, size: 5),
                Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        constraints: BoxConstraints.expand(width: 70),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '标签',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          LabelTag(
                            text: '公司',
                            padding: EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
                            textStyle: TextStyle(color: selectedTag == '公司'? Colors.white: Colors.black),
                            bgColor: selectedTag == '公司'
                                ? widget.tagBgColor
                                : Colors.white,
                            border: Border.all(
                                color: selectedTag == '公司'
                                    ? widget.tagBgColor
                                    : Color(0xFFD6D6D6)),
                            clickAction: () {
                              if(selectedTag == '公司') {
                                setState(() {
                                  selectedTag = '';
                                });
                              } else {
                                setState(() {
                                  selectedTag = '公司';
                                });
                              }
                            },
                          ),
                          PlaceHolder(size: 10),
                          LabelTag(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
                              text: '仓库',
                              textStyle: TextStyle(color: selectedTag == '仓库'? Colors.white: Colors.black),
                              bgColor: selectedTag == '仓库'
                                  ? widget.tagBgColor
                                  : Colors.white,
                              border: Border.all(
                                  color: selectedTag == '仓库'
                                      ? widget.tagBgColor
                                      : Color(0xFFD6D6D6)),
                              clickAction: () {
                                if(selectedTag == '仓库') {
                                  setState(() {
                                    selectedTag = '';
                                  });
                                } else {
                                  setState(() {
                                    selectedTag = '仓库';
                                  });
                                }
                              },
                          ),

                        ],
                      ))
                    ],
                  ),
                ),
                PlaceHolder(axis: Axis.vertical, size: 5),
                Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        constraints: BoxConstraints.expand(width: 70),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '联系人',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                          child: CupertinoTextField(
                        placeholder: '联系人',
                        decoration: BoxDecoration(
                            border: Border.all(width: 0, color: Colors.white)),
                      ))
                    ],
                  ),
                ),
                PlaceHolder(axis: Axis.vertical, size: 5),
                Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        constraints: BoxConstraints.expand(width: 70),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _sexState,
                                      onChanged: null,
                                    ),
                                    Text(
                                      '先生',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    _sexState = 1;
                                  });
                                },
                              )),
                          Container(
                              width: 100,
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 0,
                                      groupValue: _sexState,
                                      onChanged: null,
                                    ),
                                    Text(
                                      '女士',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    _sexState = 0;
                                  });
                                },
                              )),
                          Spacer()
                        ],
                      ))
                    ],
                  ),
                ),
                PlaceHolder(axis: Axis.vertical, size: 5),
                Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        constraints: BoxConstraints.expand(width: 70),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '手机',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                          child: CupertinoTextField(
                        placeholder: '手机',
                        decoration: BoxDecoration(
                            border: Border.all(width: 0, color: Colors.white)),
                      ))
                    ],
                  ),
                ),
                PlaceHolder(axis: Axis.vertical, size: 5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
