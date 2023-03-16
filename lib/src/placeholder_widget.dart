/*
 * @Author: Beoyan
 * @Date: 2023-03-16 19:08:37
 * @LastEditTime: 2023-03-16 19:08:38
 * @LastEditors: Beoyan
 * @Description: 
 */


import 'package:flutter/material.dart';

class PlaceHolderWidget extends StatelessWidget {
  final Widget child;
  const PlaceHolderWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
