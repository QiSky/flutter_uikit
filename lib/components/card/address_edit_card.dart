import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/label_tag.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class AddressEditCard extends StatefulWidget {
  final String address;

  final double latitude;

  final double longitude;

  final String name;

  final int sex;

  final String telephone;

  final String label;

  final String tag;

  final Color tagBgColor;

  final EdgeInsets padding;

  final Function? clickAddressAction;

  final Function(int gender)? sexClickAction;

  AddressEditCard(
      {this.latitude = 0.0,
      this.longitude = 0.0,
      this.name = '',
      this.sex = -1,
      this.telephone = '',
      this.label = '',
      this.tag = '',
      this.tagBgColor = Colors.blue,
      this.padding = const EdgeInsets.only(left: 15, right: 15),
      this.address = '',
      this.clickAddressAction,
      this.sexClickAction});

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
            child: Row(
              children: [
                PlaceHolder(size: 10),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PlaceHolder(
                      axis: Axis.vertical,
                      size: 5,
                    ),
                    Text('地址'),
                    PlaceHolder(
                      axis: Axis.vertical,
                      size: 4,
                    ),
                    Text(widget.address, overflow: TextOverflow.clip),
                    PlaceHolder(
                      axis: Axis.vertical,
                      size: 5,
                    ),
                  ],
                )),
                PlaceHolder(size: 5),
                Container(
                  width: 70,
                  child: LabelTag(
                      text: '修改',
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      textStyle: TextStyle(color: widget.tagBgColor),
                      bgColor: Colors.white,
                      border: Border.all(color: widget.tagBgColor),
                      clickAction: () => widget.clickAddressAction?.call()),
                ),
                PlaceHolder(size: 10)
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
                              fontSize: 17, fontWeight: FontWeight.w500),
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
                  padding: EdgeInsets.only(top: 7, bottom: 7),
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
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          LabelTag(
                            text: '公司',
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 2, bottom: 2),
                            textStyle: TextStyle(
                                color: selectedTag == '公司'
                                    ? Colors.white
                                    : Colors.black),
                            bgColor: selectedTag == '公司'
                                ? widget.tagBgColor
                                : Colors.white,
                            border: Border.all(
                                color: selectedTag == '公司'
                                    ? widget.tagBgColor
                                    : Color(0xFFD6D6D6)),
                            clickAction: () {
                              if (selectedTag == '公司') {
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
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 0, bottom: 0),
                            text: '仓库',
                            textStyle: TextStyle(
                                color: selectedTag == '仓库'
                                    ? Colors.white
                                    : Colors.black),
                            bgColor: selectedTag == '仓库'
                                ? widget.tagBgColor
                                : Colors.white,
                            border: Border.all(
                                color: selectedTag == '仓库'
                                    ? widget.tagBgColor
                                    : Color(0xFFD6D6D6)),
                            clickAction: () {
                              if (selectedTag == '仓库') {
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
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                          child: CupertinoTextField(
                        maxLength: 8,
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
                                behavior: HitTestBehavior.opaque,
                                child: Row(
                                  children: [
                                    Radio<int>(
                                      value: 1,
                                      groupValue: _sexState,
                                      activeColor: widget.tagBgColor,
                                      onChanged: (value) => _selectGenderAction(1),
                                    ),
                                    Text(
                                      '先生',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                onTap: () => _selectGenderAction(1),
                              )),
                          Container(
                              width: 100,
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Row(
                                  children: [
                                    Radio<int>(
                                      value: 0,
                                      groupValue: _sexState,
                                      activeColor: widget.tagBgColor,
                                      onChanged: (value) => _selectGenderAction(0),
                                    ),
                                    Text(
                                      '女士',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ]
                                ),
                                onTap: () => _selectGenderAction(0),
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
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                          child: CupertinoTextField(
                        keyboardType: TextInputType.phone,
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

  void _selectGenderAction(int value) {
    setState(() {
      _sexState = value;
    });
    widget.sexClickAction?.call(value);
  }
}
