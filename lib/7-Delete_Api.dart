import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteApi extends StatefulWidget {
  const DeleteApi({Key? key}) : super(key: key);

  @override
  State<DeleteApi> createState() => _DeleteApiState();
}

class _DeleteApiState extends State<DeleteApi> {
  Future getdataa() async {
    http.Response response = await http.delete(
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
