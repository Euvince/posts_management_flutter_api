import 'package:flutter/material.dart';

class MyTitle extends StatefulWidget {

  final Color color;
  final String content;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;

  const MyTitle({
    super.key,
    required this.color,
    required this.content,
    required this.fontSize,
    required this.fontFamily,
    required this.fontWeight,
  });

  @override
  State<MyTitle> createState() => _MyTitleState();
}

class _MyTitleState extends State<MyTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.content,
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 22, fontFamily: "Poppins"
          ),
        )
      ],
    );
  }
}
