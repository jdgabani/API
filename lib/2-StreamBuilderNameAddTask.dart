import 'package:flutter/material.dart';

class NameAddTask2 extends StatefulWidget {
  const NameAddTask2({Key? key}) : super(key: key);

  @override
  State<NameAddTask2> createState() => _NameAddTask2State();
}

class _NameAddTask2State extends State<NameAddTask2> {
  List<String> mylist = [];
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            SafeArea(
              child: Row(
                children: [
                  const SizedBox(
                    width: 22,
                  ),
                  Container(
                    height: 50,
                    width: 255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: "Enter Name...",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        mylist.add(controller.text);
                        controller.clear();
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.not_started_outlined,
                        color: Colors.blue,
                        size: 35,
                        shadows: [
                          Shadow(
                               color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(1, 1)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text("${mylist[index]}"),
                );
              },
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                    mylist.clear();
                  },
                  child: const Text("Clear Data")),
            ),
          ],
        ),
      ),
    );
  }
}
