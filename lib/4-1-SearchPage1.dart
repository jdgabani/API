import 'dart:convert';

import 'package:api/4-2-Api-Home-SeeAll-CategoriesPage.dart';
import 'package:api/4-4-Api-See-All-Categories.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '4-3-Api-Products-Gridview-call.dart';

class SearchPage1 extends StatefulWidget {
  const SearchPage1({Key? key}) : super(key: key);

  @override
  State<SearchPage1> createState() => _SearchPage1State();
}

class _SearchPage1State extends State<SearchPage1> {
  var Data;
  bool isSearching = false;
  bool loading = false;

  Future getdata() async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/products/search?q=${Details.text}"),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController Details = TextEditingController();

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isSearching) {
          isSearching = false;
          setState(() {});
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: TextField(
                    onTap: () {
                      isSearching = true;
                      setState(() {});
                    },
                    controller: Details,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxWidth: 320),
                      fillColor: Colors.blueGrey.shade200,
                      hintText: "Search Product..",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: Colors.blueGrey, width: 1.5),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          getdata();
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                isSearching
                    ? Data != null
                        ? loading
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3.5,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 10,
                                ),
                                shrinkWrap: true,
                                itemCount: Data["products"].length,
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
                                                  code: Data["products"][index]
                                                      ["id"],
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: Container(
                                          height: 200,
                                          width: 180,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 20),
                                          child: Image.network(
                                            Data["products"][index]
                                                ["thumbnail"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${Data["products"][index]["title"]}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "Price : \$${Data["products"][index]["price"]}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                        : const Center(
                            child: Center(child: Text('Data not found')),
                          )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const seeall(),
                                      ),
                                    );
                                  });
                                },
                                child: const Text(
                                  "See all",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black38),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const ApiSeellHomePage(),
                          const SizedBox(
                            height: 10,
                          ),
                          const ApiGridviewcall(),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
