import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {

  final Widget icon;
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const MyTextFormField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    required this.keyboardType,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            label: Text(widget.label, style: TextStyle(color: Colors.blue),),
            hintText: widget.label,
            icon: widget.icon
        ),
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Vous devez remplir ce champ";
          } return null;
        },
      ),
    );
  }
}
