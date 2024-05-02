import 'package:flutter/material.dart';
import 'package:tp_six/Models/AuthenticatedUser.dart';
import 'package:tp_six/Widgets/MyAppBar.dart';
import 'package:tp_six/Widgets/MyDrawer.dart';
import 'package:tp_six/Widgets/MyText.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String email = "";
  String fullname = "";
  AuthenticatedUser _authenticatedUser = new AuthenticatedUser();

   @override
  void initState() {
    super.initState();

    //email = _authenticatedUser.user!.email!.toString();
    //fullname = _authenticatedUser.user!.fullname!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Paramètres",),
      drawer: MyDrawer(),
      body: Center(child: MyText(content: "Informations de l'utilisateur authentifié"))
    );
  }
}
