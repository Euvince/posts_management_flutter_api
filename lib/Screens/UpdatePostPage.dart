import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp_six/Models/Post.dart';
import 'package:tp_six/Services/PostService.dart';
import 'package:tp_six/Widgets/CircularProgressIndicator.dart';
import 'package:tp_six/Widgets/MyAppBar.dart';

class UpdatePostPage extends StatefulWidget {

  final Post post;

  const UpdatePostPage({super.key, required this.post});

  @override
  State<UpdatePostPage> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {

  final _formKey = new GlobalKey<FormState>();

  final _titleController = new TextEditingController();
  final _contentController = new TextEditingController();

  bool _loading = false;

  PostService _postService = new PostService();
  Post _post = new Post();

  _updatePost () async {

    setState(() {
      _loading = true;
    });

    try {

      Map<String, dynamic> data = {
        "title" : _titleController.text,
        "content" : _contentController.text,
      };

      await _postService.updatePost(data, widget.post.id!);

      Fluttertoast.showToast(
          msg: "Le post a été édité avec succès",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM
      );

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
  void initState() {
    super.initState();

    _post = widget.post;
    _titleController.text = _post.title.toString();
    _contentController.text = _post.content.toString();
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
      appBar: MyAppBar(title: "Modifier un post",),
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
                            await _updatePost();
                          }
                        },
                        child: Text("Soumettre", style: TextStyle(color: Colors.white),),
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
