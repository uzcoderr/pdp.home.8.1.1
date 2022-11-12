import 'package:flutter/material.dart';
import 'package:pdpar2/model/Post.dart';
import 'package:pdpar2/screens/edit_post_screen.dart';
import 'package:pdpar2/service/ApiService.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  void _apiGetUsers() {
    ApiService.GET(ApiService.GET_API, ApiService.paramsEmpty())
        .then((value) => {
              setState(() {
                posts = value!;
                print(posts[0].body);
              })
            });
  }

  void _apiDeleteUsers(String api) {
    ApiService.DELETE(api, ApiService.paramsEmpty())
        .then((value) => {
    });
  }

  @override
  void initState() {
    _apiGetUsers();
    super.initState();
  }

  void nextPage(BuildContext context,Post post,int index) async{

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostUpdateScreen(post: post, index: index)),
    );

    setState(() {
      posts[index] = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Architecture Patterns'),
      ),
      body: Center(
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (doNothing){
                          _apiDeleteUsers("${ApiService.GET_API}/$index");
                          setState(() {
                            posts.removeAt(index);
                          });
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 2,
                      onPressed: (doNothing){
                        nextPage(context, posts[index], index);
                      },
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Update',
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          posts[index].title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          posts[index].body,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Divider(),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
