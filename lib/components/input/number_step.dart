import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class NumberStep extends StatefulWidget {
  late final bool isInputDisable;

  late final int min;

  late final int max;

  late final int step;

  late final int defaultValue;

  late final Color bgColor;

  final Function(int value)? valueCallBack;

  NumberStep(
      {this.defaultValue = 0,
      this.isInputDisable = false,
      this.min = 0,
      this.max = 1000,
      this.step = 1,
      this.bgColor = const Color(0xFFEDF1F4),
      this.valueCallBack});

  @override
  State<StatefulWidget> createState() => _NumberStepState();
}

class _NumberStepState extends State<NumberStep> {
  late int currentValue;

  late TextEditingController _controller =
      TextEditingController(text: widget.defaultValue.toString());

  @override
  void initState() {
    currentValue = widget.defaultValue;
    _controller.addListener(() {
      if ((int.tryParse(_controller.text) ?? 0) > widget.max) {
        setState(() {
          currentValue = widget.max;
        });
        _controller.text = widget.max.toString();
      } else if ((int.tryParse(_controller.text) ?? 0) < widget.min) {
        setState(() {
          currentValue = widget.min;
        });
        _controller.text = widget.min.toString();
      } else {
        setState(() {
          currentValue = int.parse(_controller.text);
        });
      }
      widget.valueCallBack?.call(currentValue);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Spacer(),
        InkWell(
          child: Padding(
            padding: EdgeInsets.only(left: 1, right: 1),
            child: Text(
              "-",
              style: TextStyle(
                  fontSize: 24,
                  color: currentValue <= widget.min
                      ? Color(0xFFEDF1F4)
                      : Colors.black),
            ),
          ),
          onTap: currentValue <= widget.min
              ? null
              : () {
                  if (currentValue - widget.step <= widget.min) {
                    setState(() {
                      currentValue = widget.min;
                    });
                  } else {
                    setState(() {
                      currentValue = currentValue - widget.step;
                    });
                  }
                  _controller.text = currentValue.toString();
                },
        ),
        PlaceHolder(size: 10),
        Container(
          width: 46,
          child: TextField(
              textAlign: TextAlign.center,
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(),
              toolbarOptions: ToolbarOptions(
                  copy: false, cut: false, paste: false, selectAll: false),
              readOnly: widget.isInputDisable,
              decoration: InputDecoration(
                counterText: '',
                hintText: '',
                border: InputBorder.none,
                isCollapsed: true,
                //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                //内容内边距，影响高度
                fillColor: widget.bgColor,
                //背景颜色，必须结合filled: true,才有效
                filled: true, //重点，必须设置为true，fillColor才有效
              )),
        ),
        PlaceHolder(size: 10),
        InkWell(
          child: Padding(
            padding: EdgeInsets.only(left: 1, right: 1),
            child: Text(
              "+",
              style: TextStyle(
                  fontSize: 24,
                  color: currentValue >= widget.max
                      ? Color(0xFFEDF1F4)
                      : Colors.black),
            ),
          ),
          onTap: currentValue >= widget.max
              ? null
              : () {
                  if (currentValue + widget.step >= widget.max) {
                    setState(() {
                      currentValue = widget.max;
                    });
                  } else {
                    setState(() {
                      currentValue = currentValue + widget.step;
                    });
                  }
                  _controller.text = currentValue.toString();
                },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
