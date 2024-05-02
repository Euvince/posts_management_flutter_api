import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tp_six/Models/Post.dart';
import 'package:tp_six/Screens/PostDetailsPage.dart';
import 'package:tp_six/Screens/UpdatePostPage.dart';
import 'package:tp_six/Services/PostService.dart';
import 'package:tp_six/Widgets/CircularProgressIndicator.dart';
import 'package:tp_six/Widgets/MyAppBar.dart';
import 'package:tp_six/Widgets/MyDrawer.dart';
import 'package:tp_six/Widgets/MyFloatingActionButton.dart';
import 'package:tp_six/Widgets/MyText.dart';

class PostsListPage extends StatefulWidget {
  const PostsListPage({super.key});

  @override
  State<PostsListPage> createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {

  bool _stateLoading = false;
  bool _deletingLoading = false;

  PostService _postService = new PostService();
  List<Post> _posts = [];

  _loadPosts () async {

    setState(() {
      _stateLoading = true;
    });

    try {

      _posts = await _postService.getPosts();
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
        _stateLoading = false;
      });

    }

  }

  _deletePost (final String id) async {

    setState(() {
      _deletingLoading = true;
    });

    try {

      await _postService.deletePost(id);

      Fluttertoast.showToast(
          msg: "Le post a été supprimé avec succès",
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
        _deletingLoading = false;
      });

    }

  }

  @override
  void initState() {
    super.initState();

    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Liste des posts",),
      drawer: MyDrawer(),
      floatingActionButton: MyFloatingActionButton(icon: Icons.add,),
      body: _stateLoading || _deletingLoading
        ? Center(child: MyCircularProgressIndicator(color: Colors.blue),)
        : _posts.length > 0
        ? ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (context, int index) {

            return Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.post_add_rounded),
                      title: Text(_posts[index].title!.toString(), maxLines: 2,),
                      subtitle: Text(_posts[index].content!.toString(), maxLines: 5,),
                      iconColor: Colors.blue,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PostDetailsPage(id: _posts[index].id!,))
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PostDetailsPage(id: _posts[index].id!,))
                              );
                            },
                            child: Text("Détails", style: TextStyle(color: Colors.green),)
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UpdatePostPage(post: _posts[index],))
                              );
                            },
                            child: Text("Modifier", style: TextStyle(color: Colors.blue),)
                        ),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Suppression d'un post", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),),
                                      content: Text("Êtes-vous sûr de vouloir supprimer ce post ?", style: TextStyle(fontFamily: "Poppins"),),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Annuler", style: TextStyle(color: Colors.blue),)
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              if (!_deletingLoading) {
                                                await _deletePost(_posts[index].id!);
                                                Navigator.pop(context);
                                                await _loadPosts();
                                              }
                                            },
                                            child: Text("Supprimer", style: TextStyle(color: Colors.red),)
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            child: Text("Supprimer", style: TextStyle(color: Colors.red),)
                        ),
                        SizedBox(width: 8,),
                      ],
                    )
                  ],
                )
            );
          }
      )
        : Center(child: MyText(content: "Aucun post en base de données"),)
    );
  }
}
