import 'package:api/Constant/text_style.dart';
import 'package:flutter/material.dart';

GestureDetector commonbutton(String title, Function() onTap, double height) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 2,
              blurStyle: BlurStyle.normal,
              spreadRadius: 1),
        ],
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          title,
          style: kGreen20w800,
        ),
      ),
    ),
  );
}
