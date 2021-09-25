import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentApp extends StatefulWidget {
  String? postd;
  CommentApp({this.postd});

  @override
  _CommentAppState createState() => _CommentAppState(postd);
}

class _CommentAppState extends State<CommentApp> {
  var postd;
  var deviceInfo = DeviceInfoPlugin();
  _CommentAppState(this.postd);
  Timestamp? iteam;
  int?like;
  String? description;
  String? status;

  calling() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Confession")
        .where(
          "post",
          isEqualTo: postd,
        )
        .get();
    final List<DocumentSnapshot> snap = snapshot.docs;

    if(snap.length==0){

    }else {

      setState(() {
        like = snap.first["like"];
        description = snap.first["description"];
        iteam = snap.first["Time"];
      });

    }


  }

  @override
  Widget build(BuildContext context) {
    calling();
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CupertinoTextField(
            placeholder: "Write a comment",
              placeholderStyle: TextStyle(color: Colors.grey),
            ),
          )

        ),
      ),

        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          automaticallyImplyLeading: true,
          title: Text('Nepalese Teenagers confession',style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.02),),
        ),
        body: ListView(
          children: [
            Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 5),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  shape: BoxShape.circle),
                              child: Image(
                                  image: AssetImage("assets/giveone.png"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Nepalese Teenagers Confession",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.ellipsis),
                      ),
                    ),
                    (description==null)? Text(""):Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 55, left: 12, bottom: 30),
                          child: Text(description!),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35, left: 58),
                        child:(iteam==null)?Text(""): Text(
                          timeago.format(iteam!.toDate()),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var androidDeviceInfo = await deviceInfo.androidInfo;
                          String uiddd = androidDeviceInfo.androidId;
                          final QuerySnapshot one =
                          await FirebaseFirestore.instance
                              .collection("Like")
                              .where("Like",
                              isEqualTo: "True").where("postid",isEqualTo:postd,)
                              .where("uid",isEqualTo:uiddd)
                              .get();

                          final List<DocumentSnapshot>
                          documentsnapshot = one.docs;
                          if (documentsnapshot.length == 0) {
                            FirebaseFirestore.instance
                                .collection("Like")
                                .doc(postd)
                                .set({
                              "uid":uiddd,
                              "Like": "True",
                              "postid":postd
                            }).whenComplete(() {
                              int value = like!;
                              value = value + 1;

                              FirebaseFirestore.instance
                                  .collection("Confession")
                                  .doc(postd)
                                  .update({"like": value});
                            });


                          }else
                          {
                            Fluttertoast.showToast(
                              msg: 'You already like this post',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              backgroundColor: Colors.orange,
                              textColor: Colors.black,
                            );

                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 0.1, color: Colors.grey)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.hand_thumbsup,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4,left: 2),
                                  child: Text(like.toString()),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 0.1, color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(CupertinoIcons.chat_bubble_2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 0.1, color: Colors.grey)),
                          child: Icon(Icons.share),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

            Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Comment")
                      .where("post",isEqualTo: postd)
                      .orderBy("Time", descending: true)
                      .snapshots()
                      .asBroadcastStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    valueColor:
                                    new AlwaysStoppedAnimation<Color>(Colors.blue),
                                    backgroundColor: Colors.deepOrangeAccent,
                                  ),
                                ),
                              )));
                    }
                    return Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: SafeArea(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, index) {
                            iteam = snapshot.data!.docs[index]['Time'];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                                  BoxShadow(
                                      offset: (Offset(
                                        0,
                                        5,
                                      )),
                                      color: Colors.grey)
                                ]),
                                width: MediaQuery.of(context).size.width * 1,
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, top: 5),
                                              child: Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.05,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                      color: Colors.deepOrange,
                                                      shape: BoxShape.circle),
                                                  child: Image(
                                                      image: AssetImage(
                                                          "assets/giveone.png"))),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Nepalese Teenagers Confession",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(CupertinoIcons.ellipsis),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 55, left: 12, bottom: 30),
                                              child: Text(snapshot.data!.docs[index]
                                              ["description"]),
                                            )),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 35, left: 58),
                                            child: Text(
                                              timeago.format(iteam!.toDate()),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.grey, fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 8.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.04,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 0.1,
                                                      color: Colors.grey)),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [


                                                  Icon(CupertinoIcons
                                                      .hand_thumbsup,size: 20,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 4,left: 2),
                                                    child: Text(
                                                      snapshot
                                                          .data!.docs[index]["like"]
                                                          .toString(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context,MaterialPageRoute(builder: (context)=>CommentApp(postd:snapshot.data!.docs[index]["post"])));

                                            },
                                            child: Container(
                                              height:
                                              MediaQuery.of(context).size.height *
                                                  0.04,
                                              width:
                                              MediaQuery.of(context).size.height *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 0.1,
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(
                                                    CupertinoIcons.chat_bubble_2),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(right: 8.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.04,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 0.1,
                                                      color: Colors.grey)),
                                              child: Icon(Icons.share),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
            ),











          ]
        ),
    );
  }
}
