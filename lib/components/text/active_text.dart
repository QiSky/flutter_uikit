import 'package:flutter/material.dart';
import 'package:flutter_component/components/text/overflow_text.dart';

///
/// * @ProjectName: flutter_uikit
/// * @Author: qifanxin
/// * @CreateDate: 2022/8/31 18:31
/// * @Description: 文件说明
///

class ActiveText extends StatefulWidget {
  final bool isActive;

  final String text;

  final TextStyle? style;

  final Color activeColor;

  final Color inactiveColor;

  final Function(bool)? onActiveChangeAction;

  const ActiveText(
      {this.isActive = false,
      this.text = '',
      this.style,
      required this.activeColor,
      required this.inactiveColor,
      this.onActiveChangeAction});

  @override
  State<StatefulWidget> createState() => _ActiveTextState();
}

class _ActiveTextState extends State<ActiveText> {
  late bool _isActive;

  @override
  void initState() {
    _isActive = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
        widget.onActiveChangeAction?.call(_isActive);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        color: _isActive ? widget.activeColor : widget.inactiveColor,
        child: OverflowText(widget.text, style: TextStyle(color: _isActive ? Colors.white: Colors.black),),
      ),
    );
  }
}
