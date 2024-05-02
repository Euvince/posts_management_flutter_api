import 'package:flutter/material.dart';
import 'package:tp_six/Screens/AddPostPage.dart';

class MyFloatingActionButton extends StatefulWidget {

  final icon;

  const MyFloatingActionButton({super.key, required this.icon});

  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        /* ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Bouton cliqué", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              backgroundColor: Colors.black,
            )
        ); */
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostPage())
        );
      },
      child: Icon(this.widget.icon, color: Colors.white,),
      backgroundColor: Colors.blue,
      tooltip: "Bouton Flottant",
    );
  }
}
