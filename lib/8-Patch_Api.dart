import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PatchApi extends StatefulWidget {
  const PatchApi({Key? key}) : super(key: key);

  @override
  State<PatchApi> createState() => _PatchApiState();
}

class _PatchApiState extends State<PatchApi> {
  TextEditingController nameController = TextEditingController();
  bool loading = false;
  Future getdata(title) async {
    var body = {"title": "$title"};
    setState(() {
      loading = true;
    });
    http.Response response = await http
        .patch(Uri.parse('https://dummyjson.com/products/1'), body: body);
    if (response.statusCode == 200) {
      print("${response.body}");
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patch Api")),
      body: Center(
        child: loading == true
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: "Enter here",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getdata(nameController.text);
                      });
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
      ),
    );
  }
}
