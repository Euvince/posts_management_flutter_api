import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp_six/Models/Post.dart';
import 'package:tp_six/Screens/PostsListPage.dart';
import 'package:tp_six/Services/PostService.dart';
import 'package:tp_six/Widgets/CircularProgressIndicator.dart';
import 'package:tp_six/Widgets/MyAppBar.dart';

class PostDetailsPage extends StatefulWidget {

  final String id;

  const PostDetailsPage({super.key, required this.id});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {

  bool _loading = false;

  String _postTitle = "";
  String _postContent = "";

  PostService _postService = new PostService();
  Post _post = new Post();

  void _loadOnePost () async {

    setState(() {
      _loading = true;
    });

    try {

      _post = await _postService.getPost(widget.id);
      setState(() {});

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

    _loadOnePost();
    _postTitle = _post.title.toString() ?? "Non défini";
    _postContent = _post.content.toString() ?? "Non défini";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Détails d'un post",),
      body: _loading
        ? MyCircularProgressIndicator(color: Colors.blue)
        : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "Titre du post : ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: _post.title ?? "Non défini", style: TextStyle(fontWeight: FontWeight.bold)),
                    ]
                )
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "Contenu du post : ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: _post.content ?? "Non défini", style: TextStyle(fontWeight: FontWeight.bold)),
                    ]
                )
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostsListPage())
                );
              },
              child: Text("Page précédente", style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)
              ),
            ),
          ],
        ),
      )
    );
  }
}
