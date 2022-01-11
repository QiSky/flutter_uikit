import 'package:flutter/material.dart';

import 'datetime_picker_item.dart';

class DateTimePicker extends StatefulWidget {
  final String title;

  final String confirmText;

  final String backText;

  final DateMode mode;

  final DateTime? initTime;

  final Function(DateTime confirmTime) confirmCallBack;

  const DateTimePicker(this.title, this.confirmText, this.backText, this.mode,
      this.initTime, this.confirmCallBack);

  @override
  State<StatefulWidget> createState() => _DateTimePickerState();

  static void show(BuildContext context,
      {String title = '创建时间',
      String confirmText = '确定',
      String backText = '返回',
      DateMode mode = DateMode.ymdhm,
      DateTime? initTime,
      required Function(DateTime confirmTime) confirmCallBack}) {
    showModalBottomSheet(
        context: context,
        builder: (_) => DateTimePicker(
            title, confirmText, backText, mode, initTime, confirmCallBack));
  }
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _dateTime;

  late int days;

  @override
  void initState() {
    _dateTime = widget.initTime ?? DateTime.now();
    days = DateTime(
            _dateTime.year, _dateTime.month != 12 ? _dateTime.month + 1 : 1, 0)
        .day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: AppBar(
              elevation: 0.5,
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                      child: Text(
                        widget.backText,
                        style: const TextStyle(
                            fontSize: 16, color: Color.fromRGBO(0, 77, 255, 1)),
                      ),
                      onTap: () => Navigator.of(context).pop()),
                ),
              ),
              title: Text(widget.title,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(10, 13, 20, 1),
                      fontWeight: FontWeight.w500)),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.confirmCallBack(_dateTime);
                      },
                      child: Text(
                        widget.confirmText,
                        style: const TextStyle(
                            fontSize: 16, color: Color.fromRGBO(0, 77, 255, 1)),
                      ),
                    ),
                  ),
                )
              ],
            )),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              getBody(),
              Align(
                  alignment: Alignment.topCenter,
                  child: IgnorePointer(
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color(0xFFFFFFFF),
                            Color(0x00FFFFFF),
                          ])),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: IgnorePointer(
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Color(0xFFFFFFFF),
                          Color(0x00FFFFFF),
                        ])),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget getBody() {
    late Widget body;
    switch (widget.mode) {
      case DateMode.hs:
        body = Row(
          children: [
            DateTimePickerItem(
                List.generate(24, (index) => index, growable: false), (time) {
              _dateTime = DateTime(_dateTime.year, _dateTime.month,
                  _dateTime.day, time, _dateTime.minute);
            }, '时', defaultValue: _dateTime.hour),
            DateTimePickerItem(
                List.generate(60, (index) => index, growable: false), (time) {
              _dateTime = DateTime(_dateTime.year, _dateTime.month,
                  _dateTime.day, _dateTime.hour, time);
            }, '分', defaultValue: _dateTime.minute)
          ],
        );
        break;
      case DateMode.ym:
        body = Row(
          children: [
            DateTimePickerItem(
                List.generate(100, (index) => DateTime.now().year - 50 + index,
                    growable: false), (time) {
              _dateTime = DateTime(time, _dateTime.month, _dateTime.day,
                  _dateTime.hour, _dateTime.minute);
            }, '年', defaultValue: _dateTime.year),
            DateTimePickerItem(
                List.generate(12, (index) => index + 1, growable: false),
                (time) {
              _dateTime = DateTime(_dateTime.year, time, _dateTime.day,
                  _dateTime.hour, _dateTime.minute);
            }, '月', defaultValue: _dateTime.month)
          ],
        );
        break;
      case DateMode.ymd:
        body = Row(
          children: [
            DateTimePickerItem(
                List.generate(100, (index) => DateTime.now().year - 50 + index,
                    growable: false), (time) {
              _dateTime = DateTime(time, _dateTime.month, _dateTime.day,
                  _dateTime.hour, _dateTime.minute);
              setState(() {
                days = DateTime(time, _dateTime.month, 0).day;
              });
            }, '年', defaultValue: _dateTime.year),
            DateTimePickerItem(
                List.generate(12, (index) => index + 1, growable: false),
                (time) {
              setState(() {
                if (_dateTime.day >
                    DateTime(_dateTime.year, time != 12 ? time + 1 : 1, 0)
                        .day) {
                  _dateTime = DateTime(
                      _dateTime.year,
                      time,
                      DateTime(_dateTime.year, time != 12 ? time + 1 : 1, 0)
                          .day,
                      _dateTime.hour,
                      _dateTime.minute);
                } else {
                  _dateTime = DateTime(_dateTime.year, time, _dateTime.day,
                      _dateTime.hour, _dateTime.minute);
                }
                days =
                    DateTime(_dateTime.year, time != 12 ? time + 1 : 1, 0).day;
              });
            }, '月', defaultValue: _dateTime.month),
            DateTimePickerItem(
                List.generate(days, (index) => index + 1, growable: true),
                (time) {
              _dateTime = DateTime(_dateTime.year, _dateTime.month, time,
                  _dateTime.hour, _dateTime.minute);
            }, '日', defaultValue: _dateTime.day)
          ],
        );
        break;
      case DateMode.ymdhm:
        body = Row(
          children: [
            DateTimePickerItem(
                List.generate(100, (index) => DateTime.now().year - 50 + index,
                    growable: false), (time) {
              _dateTime = DateTime(time, _dateTime.month, _dateTime.day,
                  _dateTime.hour, _dateTime.minute);
              setState(() {
                days = DateTime(time, _dateTime.month, 0).day;
              });
            }, '年', defaultValue: _dateTime.year),
            DateTimePickerItem(
                List.generate(12, (index) => index + 1, growable: false),
                (time) {
              setState(() {
                if (_dateTime.day >
                    DateTime(_dateTime.year, time != 12 ? time + 1 : 1, 0)
                        .day) {
                  _dateTime = DateTime(
                      _dateTime.year,
                      time,
                      DateTime(_dateTime.year, time != 12 ? time + 1 : 1, 0)
                          .day,
                      _dateTime.hour,
                      _dateTime.minute);
                } else {
                  _dateTime = DateTime(_dateTime.year, time, _dateTime.day,
                      _dateTime.hour, _dateTime.minute);
                }
                days =
                    DateTime(_dateTime.year, time != 12 ? time + 1 : 1, 0).day;
              });
            }, '月', defaultValue: _dateTime.month),
            DateTimePickerItem(
                List.generate(days, (index) => index + 1, growable: true),
                (time) {
              _dateTime = DateTime(_dateTime.year, _dateTime.month, time,
                  _dateTime.hour, _dateTime.minute);
            }, '日', defaultValue: _dateTime.day),
            DateTimePickerItem(
                List.generate(24, (index) => index, growable: false), (time) {
              _dateTime = DateTime(_dateTime.year, _dateTime.month,
                  _dateTime.day, time, _dateTime.minute);
            }, '时', defaultValue: _dateTime.hour),
            DateTimePickerItem(
                List.generate(60, (index) => index, growable: false), (time) {
              _dateTime = DateTime(_dateTime.year, _dateTime.month,
                  _dateTime.day, _dateTime.hour, time);
            }, '分', defaultValue: _dateTime.minute)
          ],
        );
        break;
    }
    return body;
  }
}

enum DateMode {
  ym,
  hs,
  ymdhm,
  ymd,
}
