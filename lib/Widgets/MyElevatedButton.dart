import 'package:flutter/material.dart';

class MyElevatedButton extends StatefulWidget {

  final String label;
  final Color textColor;
  final MaterialStatePropertyAll<EdgeInsetsGeometry> padding;
  final MaterialStatePropertyAll<Color?>? backgroundColor;

  const MyElevatedButton({
    super.key,
    required this.label,
    required this.padding,
    required this.textColor,
    required this.backgroundColor
  });

  @override
  State<MyElevatedButton> createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {},
      child: Text(widget.label, style: TextStyle(color: widget.textColor),),
      style: ButtonStyle(
          padding: widget.padding,
          backgroundColor: MaterialStatePropertyAll(Colors.blue)
      ),
    );
  }
}
