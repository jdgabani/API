import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostApi extends StatefulWidget {
  const PostApi({Key? key}) : super(key: key);

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {




  TextEditingController nameController = TextEditingController();
  bool loading = false;
  var data = [];

  @override
  void initState() {
    getdata();
    super.initState();
  }

  Future getdata() async {
    setState(() {
      loading = true;
    });
    http.Response response = await http
        .get(Uri.parse('https://lokdayro.in/AndroidClass/user/get_all_events.php'),);
    if (response.statusCode == 200) {
      print("data"+ response.body['all_event']);
      setState(() {
      // data = response.body;
      loading = false;
      });
      print("data"+ data.toString());
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
      appBar: AppBar(title: const Text("Post Api")),
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
                    child: Text(""),
                    // child: TextField(
                    //   controller: nameController,
                    //   decoration: const InputDecoration(
                    //       hintText: "Enter here",
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //       ),
                    //       contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    // ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // getdata(nameController.text);
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
