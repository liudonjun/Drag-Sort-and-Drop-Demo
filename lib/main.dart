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

class Item {
  String name;
  String imgSrc;

  Item(this.name, this.imgSrc);
}

class DragAndDrop extends StatefulWidget {
  @override
  _DragAndDropState createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  List<Item> _leftItems = [
    Item("卸货申请", 'discharge.png'),
    Item("卸货签收", 'sign_for.png'),
    Item("计量任务", 'measure.png'),
  ];
  List<Item> _rightItems = [
    Item("盘点任务", 'inventory_task.png'),
    Item("验货任务", 'inspection_task.png'),
    Item("装车任务", 'loading_task.png'),
  ];

  Item? _draggedItem;

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
            children: _leftItems.length > 0
                ? _leftItems
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
                              child: Text('${item.name}',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                            ),
                          ),
                          childWhenDragging: Container(
                            //拖拽后替换元素
                            width: 100,
                            height: 100,
                            color: Colors.blue.withOpacity(0.5),
                            child: Image.asset('assets/images/${item.imgSrc}'),
                          ),
                          child: DragTarget<Item>(
                            onAccept: (data) {
                              // 处理排序 和新增删除逻辑
                              print('accept index $data');
                              print('is: ${_leftItems.contains(data)}');
                              if (_leftItems.contains(data)) {
                                setState(() {
                                  // final temp = widget._list[data];
                                  _leftItems.remove(data);
                                  _leftItems.insert(index, data);
                                });
                              } else {
                                setState(() {
                                  _leftItems.insert(index, data);
                                  _rightItems.remove(data);
                                });
                              }
                            },
                            onWillAccept: (data) {
                              print(
                                  'current index: $index, on will accept $data');
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
                                    child: Text('${item.name}'),
                                  ),
                                ),
                              );
                            },
                          ),
                        )))
                    .values
                    .toList()
                : [
                    Container(
                      child: DragTarget<Item>(
                        onAccept: (data) {
                          // 处理排序 和新增删除逻辑
                          print('accept index $data');
                          setState(() {
                            _leftItems.insert(0, data);
                            _rightItems.remove(data);
                          });
                        },
                        onWillAccept: (data) {
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
                                child: Text('空'),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
          )),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _rightItems.length > 0
                    ? _rightItems
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
                                  child: Text('${item.name}',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white)),
                                ),
                              ),
                              childWhenDragging: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.blue.withOpacity(0.5),
                                  child: Image.asset(
                                      'assets/images/${item.imgSrc}')),
                              onDragStarted: () {
                                print('onDragStarted');
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
                              child: DragTarget<Item>(
                                onAccept: (data) {
                                  // 处理排序 和新增删除逻辑
                                  print('accept index $data');
                                  print('is: ${_rightItems.contains(data)}');
                                  if (_rightItems.contains(data)) {
                                    setState(() {
                                      // final temp = widget._list[data];
                                      _rightItems.remove(data);
                                      _rightItems.insert(index, data);
                                    });
                                  } else {
                                    setState(() {
                                      _rightItems.insert(index, data);
                                      _leftItems.remove(data);
                                    });
                                  }
                                },
                                onWillAccept: (data) {
                                  print(
                                      'current index: $index, on will accept $data');
                                  return true;
                                },
                                onLeave: (data) {
                                  print('index $index , leave $data');
                                },
                                builder: (context, data, rejects) {
                                  print('builder = $data,  rejects= $rejects');
                                  return Container(
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.red.withOpacity(0.5),
                                      child: Center(
                                        child: Text('${item.name}'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )))
                        .values
                        .toList()
                    : [
                        Container(
                          child: DragTarget<Item>(
                            onAccept: (data) {
                              print('accept index $data');
                              // 处理排序 和新增删除逻辑
                              setState(() {
                                _rightItems.insert(0, data);
                                _leftItems.remove(data);
                              });
                            },
                            onWillAccept: (data) {
                              // print('current index: $index, on will accept $data');
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
                                    child: Text('空'),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ]),
          ),
        ],
      ),
    );
  }
}
