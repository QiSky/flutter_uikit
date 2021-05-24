import 'package:flutter/widgets.dart';

class ContentInput extends StatefulWidget {

  final double leftPadding;

  final double rightPadding;

  ContentInput({this.leftPadding = 12.0, this.rightPadding = 12.0});

  @override
  State<StatefulWidget> createState() => _ContentInputState();

}

class _ContentInputState extends State<ContentInput> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      padding: EdgeInsets.only(left: widget.leftPadding, right: widget.rightPadding),
      child: Row(
        children: [

        ],
      ),
    );
  }

}