import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PutApi extends StatefulWidget {
  const PutApi({Key? key}) : super(key: key);

  @override
  State<PutApi> createState() => _PutApiState();
}

class _PutApiState extends State<PutApi> {
  TextEditingController name = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController name3 = TextEditingController();
  bool loading = false;
  Future getData(title, price, stock) async {
    var body = {
      "title": "$title",
      "price": "$price",
      "stock": "$stock",
    };
    setState(() {
      loading = true;
    });
    http.Response response = await http
        .put(Uri.parse('https://dummyjson.com/products/1'), body: body);
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
      appBar: AppBar(title: const Text("Put Api")),
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
                      controller: name,
                      decoration: const InputDecoration(
                          hintText: "Enter Product Name",
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
                  Container(
                    height: 50,
                    width: 255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: TextField(
                      controller: name2,
                      decoration: const InputDecoration(
                          hintText: "Enter Price",
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
                  Container(
                    height: 50,
                    width: 255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: TextField(
                      controller: name3,
                      decoration: const InputDecoration(
                          hintText: "Stock Qty",
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
                        getData(name.text, name2.text, name3.text);
                        name.clear();
                        name2.clear();
                        name3.clear();
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
