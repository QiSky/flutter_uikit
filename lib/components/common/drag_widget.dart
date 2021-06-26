import 'package:flutter/cupertino.dart';

class DragWidget extends StatefulWidget {
  final double initDx;

  final double initDy;

  final Function(double dx, double dy)? dragCallBack;

  final Function? onClickAction;

  final Widget? child;

  DragWidget(this.initDx, this.initDy, {this.onClickAction, this.dragCallBack, this.child});

  @override
  State<StatefulWidget> createState() => _DragState();
}

class _DragState extends State<DragWidget> {
  late double dx;
  late double dy;

  bool isShow = true;

  @override
  void initState() {
    dx = widget.initDx;
    dy = widget.initDy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: dx,
        top: dy,
        child: GestureDetector(
          child:Draggable(
            onDragEnd: (DraggableDetails details) {
              setState(() {
                dx = details.offset.dx;
                dy = details.offset.dy;
                isShow = true;
              });
              widget.dragCallBack?.call(dx, dy);
            },
            onDragStarted: () {
              setState(() {
                isShow = false;
              });
            },
            child: Visibility(
              visible: isShow,
              child: widget.child??Container(),
            ),
            feedback: widget.child??Container(),
          ),
          onTap: () => widget.onClickAction?.call(),
        ));
  }
}