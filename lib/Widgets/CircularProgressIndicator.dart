import 'package:flutter/material.dart';

class MyCircularProgressIndicator extends StatefulWidget {

  final Color color;

  const MyCircularProgressIndicator({super.key, required this.color});

  @override
  State<MyCircularProgressIndicator> createState() => _MyCircularProgressIndicatorState();
}

class _MyCircularProgressIndicatorState extends State<MyCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 6,
      color: widget.color,
    );
  }
}
