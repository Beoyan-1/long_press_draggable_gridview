/*
 * @Author: Beoyan
 * @Date: 2023-03-16 20:38:29
 * @LastEditTime: 2023-03-16 20:38:30
 * @LastEditors: Beoyan
 * @Description: 
 */

import 'dart:developer';
import 'package:example/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:long_press_draggable_gridview/long_press_draggable_gridview.dart';
import '../widgets/grid_item_widget.dart';

class GridSliverExample extends StatefulWidget {
  GridSliverExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  GridSliverExampleState createState() => GridSliverExampleState();
}

class GridSliverExampleState extends State<GridSliverExample> {
  List<DraggableGridItem> _listOfDraggableGridItem = [];

  List<DraggableGridItem> _seconde = [
    DraggableGridItem(
        child: GridItem(image: Images.asset_7), isDraggable: true),
    DraggableGridItem(
        child: GridItem(image: Images.asset_8), isDraggable: true),
    DraggableGridItem(
        child: GridItem(image: Images.asset_9), isDraggable: true),
    DraggableGridItem(
        child: GridItem(image: Images.asset_10), isDraggable: true),
    DraggableGridItem(
        child: GridItem(image: Images.asset_11), isDraggable: true),
    DraggableGridItem(
        child: GridItem(image: Images.asset_12), isDraggable: true)
  ];

  @override
  void initState() {
    _generateImageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
          ),
        ),
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverDraggableGridViewBuilder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                ),
                children: _listOfDraggableGridItem,
                dragCompletion: onDragAccept,
                dragFeedback: feedback,
                dragPlaceHolder: placeHolder),
            SliverToBoxAdapter(
              child: Container(
                  height: 50, color: Colors.greenAccent, child: Text('分割')),
            ),
            SliverDraggableGridViewBuilder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                ),
                children: _seconde,
                dragCompletion: onDragAccept2,
                dragFeedback: feedback,
                dragPlaceHolder: placeHolder),
          ],
        )));
  }

  Widget feedback(List<DraggableGridItem> list, int index) {
       final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: list[index].child,
      width: width / 2,
      height: (width / 2) / width * (height / 3),
    );
  }

  PlaceHolderWidget placeHolder(List<DraggableGridItem> list, int index) {
    return PlaceHolderWidget(
      child: Container(
        color: Colors.white,
      ),
    );
  }

  void onDragAccept(
      List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
    log('onDragAccept: $beforeIndex -> $afterIndex');
  }

  void onDragAccept2(
      List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
    log('onDragAccept22222: $beforeIndex -> $afterIndex');
  }

  void _generateImageData() {
    _listOfDraggableGridItem.addAll(
      [
        DraggableGridItem(
          child: GridItem(image: Images.asset_1),
          isDraggable: true,
        ),
        DraggableGridItem(
            child: GridItem(image: Images.asset_2), isDraggable: true),
        DraggableGridItem(
            child: GridItem(image: Images.asset_3), isDraggable: true),
        DraggableGridItem(
            child: GridItem(image: Images.asset_4), isDraggable: true),
        DraggableGridItem(
            child: GridItem(image: Images.asset_5), isDraggable: false),
        DraggableGridItem(
            child: GridItem(image: Images.asset_6), isDraggable: true),
      ],
    );
  }
}
