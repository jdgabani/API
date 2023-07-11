import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Api/Api-Routeds/Dart_file.dart';
import 'Model/Response/Product_response_model.dart';

class ApiGridviewcall extends StatefulWidget {
  const ApiGridviewcall({Key? key}) : super(key: key);

  @override
  State<ApiGridviewcall> createState() => _ApiGridviewcallState();
}

class _ApiGridviewcallState extends State<ApiGridviewcall> {
  var Data;
  ProductResponseModel? productResponseModel;

  Future<ProductResponseModel> getdata() async {
    http.Response response = await http.get(
      Uri.parse("${ApiRoutes.products}"),
    );
    if (response.statusCode == 200) {
      productResponseModel = productResponseModelFromJson(response.body);
    } else {
      print("${response.statusCode}");
    }
    return productResponseModel!;
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
      child: FutureBuilder<ProductResponseModel>(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: 480,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 30,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 3.0),
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
                                    code: snapshot.data!.products[index].id),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 200,
                          width: 180,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Image.network(
                            snapshot.data!.products[index].thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${snapshot.data!.products[index].title}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        "Price : \$${snapshot.data!.products[index].price}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class FakeApi extends StatefulWidget {
  const FakeApi({Key? key, this.code}) : super(key: key);
  final code;

  @override
  State<FakeApi> createState() => _FakeApiState();
}

class _FakeApiState extends State<FakeApi> {
  var data1;
  Future<Map> getdata1() async {
    http.Response response1 = await http.get(
      Uri.parse('https://dummyjson.com/products/${widget.code}'),
    );
    if (response1.statusCode == 200) {
      print("${response1.body}");
      data1 = jsonDecode(response1.body);
    } else {
      print("${response1.statusCode}");
    }
    return data1;
  }

  @override
  void initState() {
    super.initState();
    getdata1();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<Map>(
            future: getdata1(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 400,
                          child: PageView.builder(
                            itemCount: snapshot.data!["images"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 300,
                                width: 390,
                                child: Image.network(
                                  snapshot.data!['images'][index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data!["title"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "${snapshot.data!["description"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Price : \$${snapshot.data!["price"]}.00",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Discount : ${snapshot.data!["discountPercentage"]}%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Rating : ${snapshot.data!["rating"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Stock In : ${snapshot.data!["stock"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Brand : ${snapshot.data!["brand"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Category : ${snapshot.data!["category"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("wrong");
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
