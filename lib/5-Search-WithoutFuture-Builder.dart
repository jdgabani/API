import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
  bool loading = false;
  var data;

  Future getData() async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(
      Uri.parse(
          'https://dummyjson.com/products/search?q=${textEditingController.text}'),
    );
    try {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print("RESPONSE $data");
        setState(() {
          loading = false;
        });
      } else {
        print('STATUS ${response.statusCode}');
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print('ERROR $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SafeArea(
            child: TextField(
              onChanged: (value) {
                getData();
              },
              controller: textEditingController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                getData();
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                hintText: "Search product",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
          ),
          const Spacer(),
          loading
              ? const Center(child: CircularProgressIndicator())
              : data == null
                  ? const Center(child: Text("NoData"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data["products"].length,
                      itemBuilder: (context, index) =>
                          Text("${data["products"][index]["title"]}"),
                    ),
          const Spacer(),
        ],
      ),
    );
  }
}
