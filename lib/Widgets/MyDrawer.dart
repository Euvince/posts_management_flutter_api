import 'package:flutter/material.dart';
import 'package:tp_six/Screens/AddPostPage.dart';
import 'package:tp_six/Screens/PostsListPage.dart';
import 'package:tp_six/Screens/SettingsPage.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Text("PO", style: TextStyle(fontSize: 70),),
                      radius: 50,
                    ),
                    Text("Gestion des posts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ],
                )
            ),
            ListTile(
              title: Text("Ajouter un post", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              leading: Icon(Icons.add),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddPostPage())
                );
              },
            ),
            ListTile(
              title: Text("Liste des posts", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              leading: Icon(Icons.contacts),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostsListPage())
                );
              },
            ),
            ListTile(
              title: Text("Paramètres", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage())
                );
              },
            )
          ],
        )
    );
  }
}
