import 'dart:developer';

import 'package:api/View/Widget/common_button.dart';
import 'package:flutter/material.dart';

class FlutterLifeCycle extends StatefulWidget {
  const FlutterLifeCycle({Key? key}) : super(key: key);

  @override
  State<FlutterLifeCycle> createState() => _FlutterLifeCycleState();
}

class _FlutterLifeCycleState extends State<FlutterLifeCycle> {
  int counter = 0;

  Future<int> getData() async {
    await Future.delayed(Duration(seconds: 2));

    return 10;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log('hello');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text('${snapshot.data}');
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Text(
              '${counter}',
              style: TextStyle(fontSize: 50),
            ),
            commonbutton(
              'register',
                  () {
                counter++;
                log('VALUE ${counter}');
              },
              65,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant FlutterLifeCycle oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    }
}
