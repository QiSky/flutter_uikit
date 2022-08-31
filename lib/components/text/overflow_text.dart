import 'package:flutter/material.dart';
import 'package:flutter_component/components/common/overlay_widget.dart';

///
/// * @ProjectName: flutter_uikit
/// * @Author: qifanxin
/// * @CreateDate: 2022/8/31 18:20
/// * @Description: 文件说明
///

class OverflowText extends StatelessWidget {
  const OverflowText(this.text,
      {Key? key, this.style, this.maxLines = 1, this.textAlign})
      : super(key: key);

  /// 文本
  final String text;

  ///最大行数
  final int maxLines;

  ///对齐方式
  final TextAlign? textAlign;

  ///文本样式
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      // Build the TextSpan
      var span = TextSpan(
        text: text,
        style: style,
      );

      // Use a TextPainter to determine if it will exceed max lines
      var tp = TextPainter(
        maxLines: maxLines,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        text: span,
      );

      // trigger it to layout
      tp.layout(maxWidth: constrains.maxWidth);

      // whether the text overflowed or not
      var isOverflow = tp.didExceedMaxLines;

      var textWidget = Text(
        text,
        style: style,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: textAlign,
      );
      if (!isOverflow) {
        return textWidget;
      } else {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => OverlayWidget(child: SelectableText(text)),
            );
          },
          child: textWidget,
        );
      }
    });
  }
}
