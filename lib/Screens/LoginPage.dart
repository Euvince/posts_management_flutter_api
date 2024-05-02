import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp_six/Models/AuthenticatedUser.dart';
import 'package:tp_six/Screens/PostsListPage.dart';
import 'package:tp_six/Screens/RegisterPage.dart';
import 'package:tp_six/Services/UserService.dart';
import 'package:tp_six/Widgets/CircularProgressIndicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = new GlobalKey<FormState>();
  final _fullnameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  bool _loading = false;

  final UserService _userService = new UserService();

  _login () async {
    
    setState(() {
      _loading = true;
    });

    try {

      Map<String, dynamic> data = {
        "strategy" : "local",
        "email" : _emailController.text,
        "password" : _passwordController.text,
      };

      AuthenticatedUser _authenticatedUser = await _userService.login(data);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.setString("token", _authenticatedUser.accessToken!);

      _emailController.text = "";
      _passwordController.text = "";

      Fluttertoast.showToast(
        msg: "Connexion réussie",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PostsListPage())
        );
      });

    }on DioException catch(e) {

      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.statusCode);
      }else {
        print(e.requestOptions);
        print(e.message);
      }

      Fluttertoast.showToast(
          msg: "Une erreur s'est produite",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM
      );
    }finally {
      
      setState(() {
        _loading = false;
      });
      
    }

  }

  @override
  void dispose() {
    super.dispose();

    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Image.asset("assets/images/profileN.jpg",),
                      radius: 150,
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Informations de connexion",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 22, fontFamily: "Poppins"
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            label: Text("Email*", style: TextStyle(color: Colors.blue),),
                            hintText: "Email**",
                            icon: Icon(Icons.email)
                        ),
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vous devez remplir ce champ";
                          } return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            label: Text("Mot de passe*", style: TextStyle(color: Colors.blue),),
                            hintText: "Mot de passe*",
                            icon: Icon(Icons.lock)
                        ),
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vous devez remplir ce champ";
                          } return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        !_loading
                        ? ElevatedButton(
                          onPressed: () async {
                            if (!_loading && _formKey.currentState!.validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await _login();
                            }
                          },
                          child: Text("Se connecter", style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                              backgroundColor: MaterialStatePropertyAll(Colors.blue)
                          ),
                        )
                        : MyCircularProgressIndicator(color: Colors.blue),
                        SizedBox(width: 8.0,),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterPage())
                            );
                          },
                          child: Text("Créer un nouveau compte", style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                              backgroundColor: MaterialStatePropertyAll(Colors.blue)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}
