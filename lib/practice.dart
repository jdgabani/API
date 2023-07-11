import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  Future getData() async {
    http.Response response = await http.get(
      Uri.parse("https://reqres.in/api/users?page=2"),
    );
    if (response.statusCode==200){
      data = jsonDecode(response.body);
      return data;
    } else {
      print("${response.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.tealAccent,
                        child: Center(
                          child: Column(
                            children: [
                              Text("${data[index]["id"]}"),
                              Text("${data[index]["email"]}"),
                              Text("${data[index]["first_name"]}"),
                              Text("${data[index]["last_name"]}"),
                              Text("${data[index]["avatar"]}")
                            ],
                          ),
                        ),
                      ),
                    );
              },
              );
            } else{
              return Center(child: CircularProgressIndicator(),);
            }
        },),
      ),
    );
  }
}
