import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpDemo extends StatefulWidget {
  const HttpDemo({Key? key}) : super(key: key);

  @override
  State<HttpDemo> createState() => _HttpDemoState();
}

class _HttpDemoState extends State<HttpDemo> {
  Future getdataa() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/products/1"),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
    } else {
      print("${response.statusCode}");
    }
  }

  @override
  void initState() {
    getdataa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
