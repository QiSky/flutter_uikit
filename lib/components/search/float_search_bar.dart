import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';

class FloatSearchBar extends StatefulWidget {
  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final void Function(String text)? onTextChangeAction;

  final Color? color;

  final void Function(String text)? onCommitAction;

  FloatSearchBar(
      {this.color = Colors.grey,
      this.margin =
          const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      this.padding = const EdgeInsets.only(top: 2, bottom: 2),
      this.onTextChangeAction,
      this.onCommitAction});

  @override
  State<StatefulWidget> createState() => _FloatSearchBarState();
}

class _FloatSearchBarState extends State<FloatSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      widget.onTextChangeAction?.call(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 1.5),
                  blurRadius: 2,
                  spreadRadius: 0.9)
            ]),
        child: Row(
          children: [
            PlaceHolder(
              size: 8,
            ),
            Icon(
              CupertinoIcons.search,
              size: 22,
              color: widget.color,
            ),
            PlaceHolder(
              size: 2,
            ),
            Expanded(
                child: CupertinoTextField(
              style: TextStyle(color: Colors.black, fontSize: 19),
              placeholder: '搜索',
              placeholderStyle: TextStyle(color: widget.color, fontSize: 16),
              controller: _controller,
              keyboardType: TextInputType.text,
              clearButtonMode: OverlayVisibilityMode.editing,
              onSubmitted: (text) => widget.onCommitAction?.call(text),
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: Colors.white)),
            )),
            PlaceHolder(
              size: 6,
            ),
          ],
        ));
  }
}
