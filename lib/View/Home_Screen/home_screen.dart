import 'package:api/Controller/counter_controller.dart';
import 'package:api/View/Widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var counter = 0;
  CounterController _controller = Get.put(CounterController());

  Future<int> getData() async {
    await Future.delayed(Duration(seconds: 2));
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Text('${snapshot.data}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          const SizedBox(height: 30),
          GetBuilder<CounterController>(
            builder: (controller) => Text(controller.counter.toString()),
          ),
          commonbutton(
            "Register",
            () {
              ;
              _controller.increment();
              print('VAlUE${counter}');
            },
            60,
          ),
        ],
      ),
    );
  }
}
