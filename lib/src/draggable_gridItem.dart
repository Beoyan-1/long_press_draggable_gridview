// ignore_for_file: file_names

/*
 * @Author: Beoyan
 * @Date: 2023-03-16 19:09:10
 * @LastEditTime: 2023-03-16 19:16:50
 * @LastEditors: Beoyan
 * @Description: 
 */

import 'package:flutter/material.dart';

/// This class helps to manage widget and dragging enable/disable.
/// [child] will show the widgets in Gridview.builder.
/// [isDraggable] is boolean, you want to allow dragging then set it true or else false.
class DraggableGridItem {
  DraggableGridItem(
      {required this.child, this.isDraggable = false, this.dragCallback}) {
    code = child.hashCode;
  }

  final bool isDraggable;
  final Widget child;
  final Function(BuildContext context, bool isDragging)? dragCallback;
  late int code;
}
