import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/hollow_point.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/util/export_util.dart';

class ProtocolDescription extends StatefulWidget {
  late final String description;

  late final TextStyle descriptionStyle;

  late final List<KeywordData>? keywordList;

  late final bool isEnableClick;

  late final Function(bool isClick)? onClickAction;

  final double? size;

  final double? innerSize;

  final Color? color;

  ///被点击按钮下的颜色
  final Color? innerColor;

  late final Color borderColor;

  late final double borderSize;

  late final int? maxLine;

  final bool isShowPoint;

  ProtocolDescription(this.description,
      {this.keywordList = const [],
      this.isShowPoint = false,
      this.maxLine = 1,
      this.descriptionStyle = const TextStyle(),
      this.isEnableClick = false,
      this.onClickAction,
      this.size = 14,
      this.innerSize = 7,
      this.innerColor = const Color(0xFFF3F3F3),
      this.color = const Color(0xFFF3F3F3),
      this.borderColor = const Color(0xFFDFDFDF),
      this.borderSize = 1});

  @override
  State<StatefulWidget> createState() => _ProtocolDescriptionState();
}

class _ProtocolDescriptionState extends State<ProtocolDescription> {
  late String _originDescription;

  bool _isClicked = false;

  @override
  void initState() {
    _originDescription = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isEnableClick
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isShowPoint ? getPoint() : Container(),
              widget.isShowPoint ? PlaceHolder(size: 5) : Container(),
              Expanded(child: getContent())
            ],
          )
        : getContent();
  }

  Widget getPoint() {
    return GestureDetector(
        child: HollowPoint(
          size: widget.size,
          innerSize: widget.innerSize,
          innerColor: _isClicked ? widget.innerColor : widget.color,
          color: widget.color,
          borderColor: widget.borderColor,
          borderSize: widget.borderSize,
        ),
        onTap: () => throttle(() {
              setState(() {
                _isClicked = !_isClicked;
              });
              widget.onClickAction?.call(_isClicked);
            }));
  }

  Widget getContent() {
    return Transform.translate(
      offset: Offset(0, -3),
      child: widget.isEnableClick ? GestureDetector(
        child: widget.keywordList!.isEmpty ? Text(widget.description,
            style: widget.descriptionStyle,
            softWrap: true,
            maxLines: widget.maxLine) : RichText(
            maxLines: widget.maxLine,
            text: TextSpan(
                style: widget.descriptionStyle, children: getRichText())),
        onTap: () {
          setState(() {
            _isClicked = !_isClicked;
          });
          widget.onClickAction?.call(_isClicked);
        }
      ) : widget.keywordList!.isEmpty ? Text(widget.description,
          style: widget.descriptionStyle,
          softWrap: true,
          maxLines: widget.maxLine) : RichText(
          maxLines: widget.maxLine,
          text: TextSpan(
              style: widget.descriptionStyle, children: getRichText())),
    );

  }

  List<InlineSpan> getRichText() {
    List<InlineSpan> widgetList = [];
    _originDescription = widget.description;
    for (int i = 0; i < widget.keywordList!.length; i++) {
      if (_originDescription.isNotEmpty) {
        String element = widget.keywordList![i].text;
        int index = _originDescription.indexOf(element);
        String tempDescription;
        if (index == 0) {
          tempDescription = _originDescription.substring(0, element.length);
          widgetList.add(TextSpan(
              text: tempDescription,
              style: widget.keywordList![i].textStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  widget.keywordList![i].onClickAction.call();
                }));
          _originDescription = _originDescription.substring(
              element.length, _originDescription.length);
        } else if (index == -1) {
          tempDescription = _originDescription;
          widgetList.add(TextSpan(
            text: tempDescription,
          ));
          _originDescription = '';
        } else {
          widgetList.add(TextSpan(
            text: _originDescription.substring(0, index),
          ));
          tempDescription =
              _originDescription.substring(index, index + element.length);
          widgetList.add(TextSpan(
              text: tempDescription,
              style: widget.keywordList![i].textStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  widget.keywordList![i].onClickAction.call();
                }));
          _originDescription = _originDescription.substring(
              index + element.length, _originDescription.length);
        }
      } else {
        break;
      }
    }
    if (_originDescription.isNotEmpty) {
      widgetList.add(TextSpan(
        text: _originDescription,
      ));
    }
    return widgetList;
  }
}

class KeywordData {
  String text;

  Function onClickAction;

  TextStyle textStyle;

  KeywordData(this.text, this.onClickAction, this.textStyle);
}
