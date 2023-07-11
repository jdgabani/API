import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '4-3-Api-Products-Gridview-call.dart';

class ApiSeellHomePage extends StatefulWidget {
  const ApiSeellHomePage({Key? key}) : super(key: key);

  @override
  State<ApiSeellHomePage> createState() => _ApiSeellHomePageState();
}

class _ApiSeellHomePageState extends State<ApiSeellHomePage> {
  var Data;
  Future<List> getdata() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/products/categories"),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    return Data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List>(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home2Categoriey(
                                    send: snapshot.data![index]),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 125,
                          margin: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade300,
                            border:
                                Border.all(color: Colors.blueGrey, width: 1),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${snapshot.data![index]}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class Home2Categoriey extends StatefulWidget {
  const Home2Categoriey({
    Key? key,
    this.send,
  }) : super(key: key);
  final send;
  @override
  State<Home2Categoriey> createState() => _Home2CategorieyState();
}

class _Home2CategorieyState extends State<Home2Categoriey> {
  var Data1;
  Future<Map> getdata1() async {
    http.Response response1 = await http.get(
      Uri.parse('https://dummyjson.com/products/category/${widget.send}'),
    );
    if (response1.statusCode == 200) {
      print("${response1.body}");
      Data1 = jsonDecode(response1.body);
    } else {
      print("${response1.statusCode}");
    }
    return Data1;
  }

  @override
  void initState() {
    super.initState();
    getdata1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map>(
          future: getdata1(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: snapshot.data!["products"].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 3.1),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FakeApi(
                                  code: snapshot.data!['products'][index]['id'],
                                ),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 200,
                          width: 180,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Image.network(
                            snapshot.data!['products'][index]["thumbnail"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "${snapshot.data!["products"][index]["title"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
