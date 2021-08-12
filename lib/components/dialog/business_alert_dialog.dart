import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/components/common/protocol_description.dart';

class BusinessAlertDialog extends StatefulWidget {
  final String title;

  late final List<KeywordData>? titleKeywordList;

  final String content;

  late final List<KeywordData>? contentKeywordList;

  final String positiveText;

  final String negativeText;

  final TextStyle positiveTextStyle;

  final TextStyle negativeTextStyle;

  final TextStyle titleStyle;

  final TextStyle contentStyle;

  final Function() onPositiveAction;

  final Function() onNegativeAction;

  final Color bgColor;

  final Color negativeBgColor;

  final Color positiveBgColor;

  final int maxLine;

  final double elevation;

  final Widget? titleChild;

  final Widget? contentChild;

  final double maxHeight;

  final double maxWidth;

  BusinessAlertDialog(this.title, this.content, this.positiveText,
      this.negativeText, this.onPositiveAction, this.onNegativeAction,
      {this.positiveTextStyle = const TextStyle(),
      this.maxLine = 3,
      this.elevation = 10,
      this.negativeTextStyle = const TextStyle(),
      this.contentKeywordList = const [],
      this.titleKeywordList = const [],
      this.titleStyle = const TextStyle(),
      this.contentStyle = const TextStyle(),
      this.bgColor = Colors.white,
      this.negativeBgColor = const Color(0xFFE3E4E6),
      this.positiveBgColor = const Color(0xFFE3E4E6),
      this.maxHeight = 180,
      this.maxWidth = 360,
      this.contentChild,
      this.titleChild});

  @override
  State<StatefulWidget> createState() => _BusinessAlertDialogState();
}

class _BusinessAlertDialogState extends State<BusinessAlertDialog> {
  late String _originTitle;

  late String _originContent;

  @override
  void initState() {
    _originTitle = widget.title;
    _originContent = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: widget.elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
        ),
        constraints: BoxConstraints(
            maxHeight: widget.maxHeight, maxWidth: widget.maxWidth),
        padding: EdgeInsets.all(25),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.titleChild ?? getTitle(),
            PlaceHolder(
              axis: Axis.vertical,
              size: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Center(
              child: widget.contentChild ?? getContent(),
            ))),
            PlaceHolder(
              axis: Axis.vertical,
              size: 25,
            ),
            Row(children: [
              Spacer(),
              CupertinoButton(
                  color: widget.negativeBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  minSize: 40,
                  padding: EdgeInsets.only(left: 36, right: 36),
                  child: Text(
                    widget.negativeText,
                    style: widget.negativeTextStyle,
                  ),
                  onPressed: () => widget.onNegativeAction.call()),
              PlaceHolder(
                size: 10,
              ),
              CupertinoButton(
                  color: widget.positiveBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  minSize: 40,
                  padding: EdgeInsets.only(left: 36, right: 36),
                  child: Text(
                    widget.positiveText,
                    style: widget.positiveTextStyle,
                  ),
                  onPressed: () => widget.onPositiveAction.call()),
              Spacer(),
            ])
          ],
        ),
      ),
    );
  }

  Widget getTitle() {
    if (widget.titleKeywordList!.isEmpty) {
      return Text(
        widget.title,
        style: widget.titleStyle,
      );
    } else {
      return RichText(
          maxLines: widget.maxLine,
          text: TextSpan(
              style: widget.titleStyle,
              children: getRichText(_originTitle, widget.titleKeywordList)));
    }
  }

  Widget getContent() {
    if (widget.contentKeywordList!.isEmpty) {
      return Text(
        widget.content,
        style: widget.contentStyle,
        textAlign: TextAlign.center,
      );
    } else {
      return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: widget.contentStyle,
              children:
                  getRichText(_originContent, widget.contentKeywordList)));
    }
  }

  List<InlineSpan> getRichText(String text, List<KeywordData>? keywordList) {
    List<InlineSpan> widgetList = [];
    for (int i = 0; i < keywordList!.length; i++) {
      if (text.isNotEmpty) {
        String element = keywordList[i].text;
        int index = text.indexOf(element);
        String tempDescription;
        if (index == 0) {
          tempDescription = text.substring(0, element.length);
          widgetList.add(TextSpan(
              text: tempDescription,
              style: keywordList[i].textStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  keywordList[i].onClickAction.call();
                }));
          text = text.substring(element.length, text.length);
        } else if (index == -1) {
          tempDescription = text;
          widgetList.add(TextSpan(
            text: tempDescription,
          ));
          text = '';
        } else {
          widgetList.add(TextSpan(
            text: text.substring(0, index),
          ));
          tempDescription = text.substring(index, index + element.length);
          widgetList.add(TextSpan(
              text: tempDescription,
              style: keywordList[i].textStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  keywordList[i].onClickAction.call();
                }));
          text = text.substring(index + element.length, text.length);
        }
      } else {
        break;
      }
    }
    if (text.isNotEmpty) {
      widgetList.add(TextSpan(
        text: text,
      ));
    }
    return widgetList;
  }
}
