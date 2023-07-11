import 'package:flutter/material.dart';

class FutureBuilderTask1 extends StatefulWidget {
  const FutureBuilderTask1({Key? key}) : super(key: key);

  @override
  State<FutureBuilderTask1> createState() => _FutureBuilderTask1State();
}

class _FutureBuilderTask1State extends State<FutureBuilderTask1> {
  Future future1() async {
    await Future.delayed(Duration(seconds: 3));
    return Data;
  }

  List<Map<String, dynamic>> Data = [
    {
      "No": "1",
      "Name": "Viraj Asodariya",
      "Age": "20",
      "Society": "Dayaram",
      "Area": "Puna Gam",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248",
    },
    {
      "No": "2",
      "Name": "Denish Sheladiya",
      "Age": "20",
      "Society": "Mamta Park",
      "Area": "Kapodra",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "393001",
    },
    {
      "No": "3",
      "Name": "Deep Vadi",
      "Age": "20",
      "Society": "Parmeshwar",
      "Area": "Yogi Chowk",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "395010",
    },
    {
      "No": "4",
      "Name": "J.D Gabani",
      "Age": "26",
      "Society": "ShivNagar",
      "Area": "Mota Varaccha",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394101",
    },
    {
      "No": "5",
      "Name": "Nikunj Munjani",
      "Age": "21",
      "Society": "Santosh Nagar",
      "Area": "Kapodra",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "393001",
    },
    {
      "No": "6",
      "Name": "Vishal Makvana",
      "Age": "22",
      "Society": "Ayodhya",
      "Area": "Puna Gam",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248 ",
    },
    {
      "No": "7",
      "Name": "Yash",
      "Age": "20",
      "Society": "Manya",
      "Area": "Vraj Chowk",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "395013",
    },
    {
      "No": "8",
      "Name": "Mahesh",
      "Age": "28",
      "Society": "Sant Devidas",
      "Area": "Sarthana",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "395013",
    },
    {
      "No": "9",
      "Name": "Nevil Vaghasiya",
      "Age": "24",
      "Society": "MeghMalhar",
      "Area": "Jakatnaka",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "395013",
    },
    {
      "No": "10",
      "Name": "Jenish Vaghasiya",
      "Age": "22",
      "Society": "Meghmalhar",
      "Area": "Jakatnak",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "395013",
    },
    {
      "No": "11",
      "Name": "Milind Sardhara",
      "Age": "21",
      "Society": " ",
      "Area": "Puna Gam",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248 ",
    },
    {
      "No": "12",
      "Name": "Denish Sheladiya",
      "Age": "20",
      "Society": "Mamta Park",
      "Area": "Kapodra",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "393001",
    },
    {
      "No": "13",
      "Name": "Laxshit Kotadiya",
      "Age": "20",
      "Society": "",
      "Area": "Puna Gam",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248 ",
    },
    {
      "No": "14",
      "Name": "Milan Nakrani",
      "Age": "23",
      "Society": "",
      "Area": "",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248 ",
    },
    {
      "No": "15",
      "Name": "Nikunj Nakrani",
      "Age": "23",
      "Society": "-",
      "Area": "-",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248 ",
    },
    {
      "No": "16",
      "Name": "Krushil Goti",
      "Age": "23",
      "Society": "",
      "Area": "",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248 ",
    },
    {
      "No": "17",
      "Name": "Ghori",
      "Age": "20",
      "Society": "-",
      "Area": "-",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248 ",
    },
    {
      "No": "18",
      "Name": "Manav",
      "Age": "22",
      "Society": "",
      "Area": "",
      "State": "Gujarat",
      "City": "Surat",
      "Pincode": "394248 ",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future1(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: Data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 280,
                  width: 400,
                  margin: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.45),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No.",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${snapshot.data[index]["No"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${snapshot.data[index]["Name"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Age : ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${snapshot.data[index]["Age"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Society : ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${snapshot.data[index]["Society"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Area : ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${snapshot.data[index]["Area"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State : ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${snapshot.data[index]["State"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "City : ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${snapshot.data[index]["City"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pincode : ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${snapshot.data[index]["Pincode"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("wrong not something"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
