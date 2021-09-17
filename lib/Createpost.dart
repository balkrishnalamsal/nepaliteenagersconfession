
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:uuid/uuid.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController? squadcontroller;
  String ? value;




  Controluploading() async {
    String post = Uuid().v4();
    debugPrint(squadcontroller.toString());
    await FirebaseDatabase.instance.reference().child("Confession").child(post).set({
      "description":squadcontroller!.text.toString(),
      "post":post,
      "Time":ServerValue.timestamp,
    });

  }

  @override
  void setState(fn) {
    super.setState(fn);
    squadcontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SafeArea(
            child: ListView(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: CupertinoTextField(
                      cursorColor: Colors.grey,
                      style: TextStyle(color: Colors.black),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 1)
                          ]),
                      maxLines: 20,
                      controller:squadcontroller,
                      placeholderStyle: TextStyle(color: Colors.grey),
                      placeholder: "What's on your mind ?",
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: CupertinoButton(
                          color: Colors.blue,
                          onPressed: () {
                            Controluploading();
                          },
                          child: Text(
                            "POST",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ))),
                ),
              ],
            ),
          ),
        ));
  }
}
