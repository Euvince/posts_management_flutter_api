import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp_six/Screens/PostsListPage.dart';
import 'package:tp_six/Services/PostService.dart';
import 'package:tp_six/Widgets/CircularProgressIndicator.dart';
import 'package:tp_six/Widgets/MyAppBar.dart';
import 'package:tp_six/Widgets/MyDrawer.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  final _formKey = new GlobalKey<FormState>();

  final _titleController = new TextEditingController();
  final _contentController = new TextEditingController();

  bool _loading = false;

  PostService _postService = new PostService();

  _createPost () async {

    setState(() {
      _loading = true;
    });

    try {

      Map<String, dynamic> data = {
        "title" : _titleController.text,
        "content" : _contentController.text,
      };

      await _postService.createPost(data);

      _titleController.text = "";
      _contentController.text = "";

      Fluttertoast.showToast(
          msg: "Le post a été crée avec succès",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
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

    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Ajouter un post",),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Informations du post",
                    style: TextStyle(
                      color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 22, fontFamily: "Poppins"
                    ),
                  )
                ],
              ),
              Image.asset("assets/images/ori_logo.png"),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Titre du post*", style: TextStyle(color: Colors.blue),),
                      hintText: "Titre du post*",
                      icon: Icon(Icons.title)
                  ),
                  controller: _titleController,
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
                      label: Text("Contenu du post*", style: TextStyle(color: Colors.blue),),
                      hintText: "Contenu du post*",
                      icon: Icon(Icons.library_books_rounded)
                  ),
                  minLines: 5,
                  maxLines: 10,
                  controller: _contentController,
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
                              await _createPost();
                            }
                          },
                          child: Text("Enrégistrer", style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                              backgroundColor: MaterialStatePropertyAll(Colors.blue)
                          ),
                        )
                      : MyCircularProgressIndicator(color: Colors.blue),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
