import 'package:flutter/material.dart';
import 'package:long_press_draggable_gridview/src/draggable_gridItem.dart';
import 'package:long_press_draggable_gridview/src/empty_item.dart';
import 'draggable_gridview_builder.dart';

class SliverDraggableGridViewBuilder extends StatefulWidget {
  /// [children] will show the widgets in Gridview.builder.
  final List<DraggableGridItem> children;

  /// [dragFeedback] you can set this to display the widget when the widget is being dragged.
  final DragFeedback? dragFeedback;

  /// [dragChildWhenDragging] you can set this to display the widget at dragged widget place when the widget is being dragged.
  final DragChildWhenDragging? dragChildWhenDragging;

  /// [dragPlaceHolder] you can set this to display the widget at the drag target when the widget is being dragged.
  final DragPlaceHolder? dragPlaceHolder;

  /// [dragCompletion] you have to set this callback to get the updated list.
  final DragCompletion dragCompletion;

  /// all the below arguments for Gridview.builder.
  final SliverGridDelegate gridDelegate;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;

  const SliverDraggableGridViewBuilder({
    Key? key,
    required this.gridDelegate,
    required this.children,
    required this.dragCompletion,
    this.dragFeedback,
    this.dragChildWhenDragging,
    this.dragPlaceHolder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
  }) : super(
          key: key,
        );

  @override
  SliverDraggableGridViewBuilderState createState() =>
      SliverDraggableGridViewBuilderState();
}

class SliverDraggableGridViewBuilderState
    extends State<SliverDraggableGridViewBuilder> {
  int overlapIndex = -1;
  bool showSrcElement = false;
  late List<DraggableGridItem> _orgList;
  late List<DraggableGridItem> _list;
  int lastIndex = 0;

  @override
  void initState() {
    super.initState();
    assert(widget.children.isNotEmpty, 'Children must not be empty.');

    /// [list] will update when the widget is beign dragged.
    _list = [...widget.children];

    /// [orgList] will set when the drag completes.
    _orgList = [...widget.children];
  }

  @override
  void didUpdateWidget(SliverDraggableGridViewBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.children.isNotEmpty, 'Children must not be empty.');
    _list = [...widget.children];
    _orgList = [...widget.children];
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: _list.length,
        gridDelegate: widget.gridDelegate,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        itemBuilder: (_, index) {
          return _buildItem(index, _list[index]);
        });
    // return GridView.builder(
    //   scrollDirection: widget.scrollDirection,
    //   reverse: widget.reverse,
    //   controller: widget.controller,
    //   primary: widget.primary,
    //   physics: widget.physics,
    //   shrinkWrap: widget.shrinkWrap,
    //   padding: widget.padding,
    //   addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
    //   addRepaintBoundaries: widget.addRepaintBoundaries,
    //   addSemanticIndexes: widget.addSemanticIndexes,
    //   semanticChildCount: widget.semanticChildCount,
    //   dragStartBehavior: widget.dragStartBehavior,
    //   keyboardDismissBehavior: widget.keyboardDismissBehavior,
    //   restorationId: widget.restorationId,
    //   clipBehavior: widget.clipBehavior,
    //   gridDelegate: widget.gridDelegate,
    //   itemBuilder: (_, index) {
    //     return _buildItem(index, _list[index]);
    //   },
    //   itemCount: _list.length,
    // );
  }

  Widget _buildItem(cindex, DraggableGridItem myData) {
    return LongPressDraggable<DraggableGridItem>(
      maxSimultaneousDrags: 1,
      data: myData,
      feedback: widget.dragFeedback?.call(_list, cindex) ?? Container(),
      onDragStarted: () {
        //开始拖动，备份数据源
        _orgList = [..._list];
      },
      childWhenDragging: showSrcElement
          ? widget.dragChildWhenDragging?.call(_orgList, cindex)
          : Container(),
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        //拖动取消，还原数据源
        setState(() {
          overlapIndex = -1;
          showSrcElement = false;
          _list = [..._orgList];
        });
      },
      onDragCompleted: () {
        //拖动完成，刷新状态
        widget.dragCompletion(_list, lastIndex, overlapIndex);
        setState(() {
          showSrcElement = false;
          overlapIndex = -1;
        });
      },
      child: DragTarget<DraggableGridItem>(
        onAccept: (data) {},
        onLeave: (details) {
          setState(() {
            overlapIndex = -1;
            showSrcElement = false;
            _list = [..._orgList];
          });
        },
        onWillAccept: (details) {
          var draggingIndex =
              _list.indexWhere((element) => element.code == details!.code);
          lastIndex =
              _orgList.indexWhere((element) => element.code == details!.code);
          if (draggingIndex == cindex) {
            showSrcElement = true;
            overlapIndex = cindex;
          } else {
            if (details != null && details.code != myData.code) {
              if (draggingIndex >= 0 && draggingIndex < _list.length) {
                setState(() {
                  _list.removeAt(draggingIndex);
                  _list.insert(cindex, details);
                  showSrcElement = true;
                  overlapIndex = cindex;
                });
              }
            }
          }
          return true;
        },
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          if (overlapIndex == cindex) {
            DraggableGridItem holder = DraggableGridItem(
                child: widget.dragPlaceHolder?.call(_orgList, cindex) ??
                    const EmptyItem(),
                isDraggable: true);
            return holder.child;
          }
          return myData.child;
        },
      ),
    );
  }
}
