import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApi extends StatefulWidget {
  const ProductApi({Key? key}) : super(key: key);

  @override
  State<ProductApi> createState() => _ProductApiState();
}

class _ProductApiState extends State<ProductApi> {
  var detail;
  Future getdata() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://dummyjson.com/products',
      ),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      detail = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    return detail;
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(
                                code: snapshot.data["products"][index]["id"],
                              ),
                            ),
                          );
                        });
                      },
                      child: Container(
                        height: 200,
                        width: 180,
                        margin:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Image.network(
                          snapshot.data["products"][index]["thumbnail"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      "${snapshot.data["products"][index]["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Price : \$${snapshot.data["products"][index]["price"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ],
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
  const Home({
    Key? key,
    this.code,
  }) : super(key: key);
  final code;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var detail1;
  Future<Map> getdata1() async {
    http.Response response1 = await http.get(
      Uri.parse('https://dummyjson.com/products/${widget.code}'),
    );
    if (response1.statusCode == 200) {
      detail1 = jsonDecode(response1.body);
    } else {
      print("${response1.statusCode}");
    }
    return detail1;
  }

  void initState() {
    getdata1();
    super.initState();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getdata1(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: Stack(
                      children: [
                        PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                selected = value;
                              });
                            },
                            itemCount: snapshot.data!["images"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 400,
                                width: 500,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data!['images'][index]),
                                  ),
                                ),
                              );
                            }),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(
                              snapshot.data!["images"].length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CircleAvatar(
                                  backgroundColor: selected == index
                                      ? Colors.black
                                      : Colors.white,
                                  radius: 4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Brand : ${snapshot.data!["title"]}",
                          style: TextStyle(
                            wordSpacing: 3,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${snapshot.data!["description"]}",
                          style: TextStyle(
                            wordSpacing: 3,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Price : \$${snapshot.data!["price"]}.00",
                          style: TextStyle(
                            wordSpacing: 3,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Discount : ${snapshot.data!["discountPercentage"]}%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Rating : ${snapshot.data!["rating"]}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Stock In : ${snapshot.data!["stock"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Brand : ${snapshot.data!["brand"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Category : ${snapshot.data!["category"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
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
