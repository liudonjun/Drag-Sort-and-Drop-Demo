import 'package:drag_demo/LongPressDraggableWidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag and Drop Demo',
      home: LongPressDraggableWidget(),
    );
  }
}

class DragAndDrop extends StatefulWidget {
  @override
  _DragAndDropState createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  List<int> _leftItems = [1, 2, 3, 4];
  List<int> _rightItems = [5, 6, 7, 8];

  int? _draggedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Demo'),
      ),
      body: Row(
        children: [
          Expanded(
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _leftItems
                      .map((item) => GestureDetector(
                            // onTap: () {
                            //   setState(() {
                            //     _leftItems.remove(item);
                            //     _rightItems.add(item);
                            //   });
                            // },
                            child: LongPressDraggable(
                              data: item,
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.blue,
                                child: Center(
                                  child: Text('$item'),
                                ),
                              ),
                              feedback: Container(
                                width: 100,
                                height: 100,
                                color: Colors.blue.withOpacity(0.5),
                                child: Center(
                                  child: Text('$item'),
                                ),
                              ),
                              childWhenDragging: Container(
                                width: 100,
                                height: 100,
                                color: Colors.blue.withOpacity(0.5),
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
              onWillAccept: (data) {
                print('left-onWillAccept:$data');
                print('right-tag---------:${_leftItems.indexOf(data as int)}');
                // 如果拖拽元素是自身，则不允许拖拽到自身上
                // return data != null && data != _leftItems;
                return _leftItems.indexOf(data as int) == -1;
              },
              onAccept: (int data) {
                print('left-onAccept:$data');
                setState(() {
                  _leftItems.add(data);
                  _rightItems.remove(data);
                });
              },
            ),
          ),
          Expanded(
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _rightItems
                      .map((item) => GestureDetector(
                            // onTap: () {
                            //   setState(() {
                            //     _rightItems.remove(item);
                            //     _leftItems.add(item);
                            //   });
                            // },
                            child: LongPressDraggable(
                              data: item,
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.red,
                                child: Center(
                                  child: Text('$item'),
                                ),
                              ),
                              feedback: Container(
                                width: 100,
                                height: 100,
                                color: Colors.red.withOpacity(0.5),
                                child: Center(
                                  child: Text('$item'),
                                ),
                              ),
                              childWhenDragging: Container(
                                width: 100,
                                height: 100,
                                color: Colors.red.withOpacity(0.5),
                              ),
                              onDragStarted: () {
                                // setState(() {
                                //   _draggedIndex = index;
                                // });
                              },
                              onDragEnd: (dragDetails) {
                                print('dragDetails:$dragDetails');
                                // setState(() {
                                //   _draggedIndex = null;
                                // });
                              },
                            ),
                          ))
                      .toList(),
                );
              },
              onWillAccept: (data) {
                print('right-onWillAccept:$data');
                print('right-tag-----:${_rightItems.indexOf(data as int)}');
                // return data != null && data != _rightItems;
                return _rightItems.indexOf(data as int) == -1;
              },
              onAccept: (int data) {
                print('right-onAccept:$data');
                setState(() {
                  _rightItems.add(data);
                  _leftItems.remove(data);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
