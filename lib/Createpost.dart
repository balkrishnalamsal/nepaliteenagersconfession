import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController? squadcontroller;
  String? value;
  String? loading = "False";
  String? button = "False";

  @override
  void initState() {
    super.initState();
    squadcontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: Container(
          child: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/giveone.png")),
                        color: Colors.deepOrange,
                        shape: BoxShape.circle),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nepalese Teenagers Confession",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
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
                      maxLines: 10,
                      controller: squadcontroller,
                      placeholderStyle: TextStyle(color: Colors.grey),
                      placeholder: "What's on your mind ?",
                    )),
                (button == "False")
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: CupertinoButton(
                                color: Colors.black,
                                onPressed: () async {
                                  Navigator.of(context);
                                  loading = "True";
                                  button = "True";
                                  String post = Uuid().v4();
                                  FirebaseFirestore.instance
                                      .collection("Confession")
                                      .doc(post)
                                      .set({
                                    "description": squadcontroller!.text,
                                    "post": post,
                                    "status": "Pending",
                                    "Time": DateTime.now(),
                                    "like":""

                                  }).whenComplete(() {
                                    setState(() {
                                      Fluttertoast.showToast(msg: 'Successfully sent for approval',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.orange,
                                        textColor: Colors.black,
                                      );
                                      button = "False";
                                      loading = "False";
                                      squadcontroller!.clear();
                                    });

                                  });
                                },
                                child: Text(
                                  "Send for Approval",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ))),
                      )
                    : Text(""),
                (loading == "False")
                    ? Text(
                        "",
                        style: TextStyle(fontSize: 0),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            width: 100,
                            child: LinearProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.black),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                      "Note: Your confession will be posted as soon as admin approved the post"),
                )
              ],
            ),
          ),
        ));
  }
}
