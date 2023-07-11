import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '4-3-Api-Products-Gridview-call.dart';

class seeall extends StatefulWidget {
  const seeall({
    Key? key,
  }) : super(key: key);
  @override
  State<seeall> createState() => _seeallState();
}

class _seeallState extends State<seeall> {
  var Data;
  Future<List> getadata() async {
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
    getadata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List>(
          future: getadata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 85),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: List.generate(
                      20,
                      (index) => InkResponse(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Catogerycollings(
                                    one: snapshot.data![index]),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.teal.shade400,
                            border:
                                Border.all(color: Colors.blueGrey, width: 1),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Center(
                            child: Text(
                              "${snapshot.data![index]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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

/////////////////////////////////////////////////////////////////////////////////////////
class Catogerycollings extends StatefulWidget {
  const Catogerycollings({Key? key, this.one}) : super(key: key);
  final one;
  @override
  State<Catogerycollings> createState() => _CatogerycollingsState();
}

class _CatogerycollingsState extends State<Catogerycollings> {
  var Data1;
  Future<Map> getdata1() async {
    http.Response response = await http.get(
      Uri.parse('https://dummyjson.com/products/category/${widget.one}'),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data1 = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
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
        child: SafeArea(
          child: FutureBuilder<Map>(
            future: getdata1(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  itemCount: snapshot.data!["products"].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 3.3),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FakeApi(
                                    code: snapshot.data!['products'][index]
                                        ['id'],
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            height: 220,
                            width: 180,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Image.network(
                              snapshot.data!['products'][index]["thumbnail"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["products"][index]["title"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "Price : ${snapshot.data!["products"][index]["price"]}.00",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
