/*
 * @Author: Beoyan
 * @Date: 2023-03-16 19:07:41
 * @LastEditTime: 2023-03-16 19:07:42
 * @LastEditors: Beoyan
 * @Description: 
 */


import 'package:flutter/material.dart';

/// [EmptyItem] will use to show at drag target, when the widget is being dragged.
class EmptyItem extends StatelessWidget {
  const EmptyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
    );
  }
}
