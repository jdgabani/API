import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPageCalling extends StatefulWidget {
  const ApiPageCalling({Key? key}) : super(key: key);

  @override
  State<ApiPageCalling> createState() => _ApiPageCallingState();
}

class _ApiPageCallingState extends State<ApiPageCalling> {
  List data = [];
  Future getdata() async {
    http.Response response = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/todos",
      ),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      print("${response.statusCode}");
      return 10;
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(
                            id: snapshot.data[index]["id"],
                          ),
                        ),
                      );
                    });
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 120),
                    color: Colors.blueGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text("${data[index]["id"]}")),
                        // Text("${data[index]["title"]}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("wrong");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, this.id}) : super(key: key);
  final id;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data1 = {};
  Future getdata1() async {
    http.Response response1 = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/todos/${widget.id}",
      ),
    );
    if (response1.statusCode == 200) {
      data1 = jsonDecode(response1.body);
      return data1;
    } else {
      print("${response1.statusCode}");
    }
  }

  void initState() {
    getdata1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getdata1(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${snapshot.data["userId"]}"),
                    Text("${snapshot.data["id"]}"),
                    Text("${snapshot.data["title"]}"),
                    Text("${snapshot.data["completed"]}"),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("wrong");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
