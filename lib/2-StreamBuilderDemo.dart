import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderDemo extends StatefulWidget {
  const StreamBuilderDemo({Key? key}) : super(key: key);

  @override
  State<StreamBuilderDemo> createState() => _StreamBuilderDemoState();
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {
  StreamController<int> Counter = StreamController();
  int data = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Counter.sink.add(0);
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Center(
          child: StreamBuilder<int>(
              stream: Counter.stream,
              builder: (context, Snapshort) {
                if (Snapshort.hasData) {
                  data = data + Snapshort.data!;
                  return Text("${data++}");
                } else if (Snapshort.hasError) {
                  return Text("wrong");
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
