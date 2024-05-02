import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp_six/Screens/LoginPage.dart';
import 'package:tp_six/Services/UserService.dart';
import 'package:tp_six/Widgets/CircularProgressIndicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = new GlobalKey<FormState>();

  final _fullnameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  bool _loading = false;

  final UserService _userService = new UserService();

  _register () async {

    setState(() {
      _loading = true;
    });

    try {

      Map<String, dynamic> data = {
        "email" : _emailController.text,
        "fullname" : _fullnameController.text,
        "password" : _passwordController.text,
      };

      await _userService.register(data);

      _emailController.text = "";
      _fullnameController.text = "";
      _passwordController.text = "";

      Fluttertoast.showToast(
          msg: "Utilisateur crée avec succès",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage())
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
                          "Informations d'utilisateur",
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
                            label: Text("Nom et prénoms*", style: TextStyle(color: Colors.blue),),
                            hintText: "Nom et prénoms*",
                            icon: Icon(Icons.person)
                        ),
                        controller: _fullnameController,
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
                              await _register();
                            }
                          },
                          child: Text("Créer un compte", style: TextStyle(color: Colors.white),),
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
                                MaterialPageRoute(builder: (context) => const LoginPage())
                            );
                          },
                          child: Text("Se connecter", style: TextStyle(color: Colors.white),),
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
          ),
        ),
      )
    );
  }
}
