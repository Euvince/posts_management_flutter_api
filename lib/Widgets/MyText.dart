import 'package:flutter/material.dart';

class MyText extends StatefulWidget {

  final String content;

  const MyText({super.key, required this.content});

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.content, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),);
  }
}
