import 'package:drag_demo/LongPressDraggableWidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag Sort and Drop Demo',
      home: DragAndDrop(),
    );
  }
}

class DragAndDrop extends StatefulWidget {
  @override
  _DragAndDropState createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  List<dynamic> _leftItems = [1, 2, 3, 4];
  List<dynamic> _rightItems = [5, 6, 7, 8];

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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _leftItems
                .asMap()
                .map((index, item) => MapEntry(
                    index,
                    LongPressDraggable(
                      data: item,
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
                      child: DragTarget<int>(
                        onAccept: (data) {
                          // 处理排序 和新增删除逻辑
                          print('accept index $data');
                          if (_leftItems.indexOf(data as int) == -1) {
                            setState(() {
                              _leftItems.insert(index, data);
                              _rightItems.remove(data);
                            });
                          } else {
                            setState(() {
                              // final temp = widget._list[data];
                              _leftItems.remove(data);
                              _leftItems.insert(index, data);
                            });
                          }
                        },
                        onWillAccept: (data) {
                          print('current index: $index, on will accept $data');
                          return true;
                        },
                        onLeave: (data) {
                          // print('index $index , leave $data');
                        },
                        builder: (context, data, rejects) {
                          print('builder = $data,  rejects= $rejects');
                          return Container(
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.red.withOpacity(0.5),
                              child: Center(
                                child: Text('$item'),
                              ),
                            ),
                          );
                        },
                      ),
                    )))
                .values
                .toList(),
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _rightItems
                .asMap()
                .map((index, item) => MapEntry(
                    index,
                    LongPressDraggable(
                      data: item,
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
                        color: Colors.blue.withOpacity(0.5),
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
                      child: DragTarget<int>(
                        onAccept: (data) {
                          // 处理排序 和新增删除逻辑
                          print('accept index $data');
                          if (_rightItems.indexOf(data as int) == -1) {
                            setState(() {
                              _rightItems.insert(index, data);
                              _leftItems.remove(data);
                            });
                          } else {
                            setState(() {
                              // final temp = widget._list[data];
                              _rightItems.remove(data);
                              _rightItems.insert(index, data);
                            });
                          }
                        },
                        onWillAccept: (data) {
                          print('current index: $index, on will accept $data');
                          return true;
                        },
                        onLeave: (data) {
                          // print('index $index , leave $data');
                        },
                        builder: (context, data, rejects) {
                          print('builder = $data,  rejects= $rejects');
                          return Container(
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.red.withOpacity(0.5),
                              child: Center(
                                child: Text('$item'),
                              ),
                            ),
                          );
                        },
                      ),
                    )))
                .values
                .toList(),
          )),
        ],
      ),
    );
  }
}
