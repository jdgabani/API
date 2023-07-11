import 'package:api/Constant/color_helper.dart';
import 'package:flutter/material.dart';

Expanded products() {
  return Expanded(
    child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 65,
          color: kPink,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(
              Icons.person_outline,
              size: 40,
              color: Colors.white70,
            ),
            title: Text(
              "Person",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            trailing: Icon(
              Icons.edit,
              color: Colors.white70,
            ),
            horizontalTitleGap: 10,
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          ),
        );
      },
    ),
  );
}
