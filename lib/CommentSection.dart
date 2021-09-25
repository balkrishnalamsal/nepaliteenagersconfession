import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentApp extends StatefulWidget {
  String ? postd;
  CommentApp({@required this.postd});


  @override
  _CommentAppState createState() => _CommentAppState(postd);
}

class _CommentAppState extends State<CommentApp> {
  var postd;
  var deviceInfo = DeviceInfoPlugin();
  _CommentAppState(this.postd);




  Timestamp? iteam;

  calling()async{
       QuerySnapshot snapshot =
    await FirebaseFirestore.instance
        .collection("Confession")
        .where("post",isEqualTo:postd,)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    calling();
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Material App Bar'),
        ),
        body:Padding(
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
                          child: Text(""),
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
                      GestureDetector(
                        onTap: () async {
                          var androidDeviceInfo = await deviceInfo.androidInfo;
                          String uiddd = androidDeviceInfo.androidId;
                          final QuerySnapshot one =
                          await FirebaseFirestore.instance
                              .collection("Like")
                              .where("Like",
                              isEqualTo: "True").where("postid",isEqualTo:"cominguid",)
                              .where("uid",isEqualTo:uiddd)
                              .get();

                          final List<DocumentSnapshot>
                          documentsnapshot = one.docs;
                          if (documentsnapshot.length == 0) {
                            FirebaseFirestore.instance
                                .collection("Like")
                                .doc(snapshot.data!.docs[index]["post"])
                                .set({
                              "uid":uiddd,
                              "Like": "True",
                              "postid":cominguid
                            }).whenComplete(() {
                              int value = snapshot
                                  .data!.docs[index]["like"];
                              value = value + 1;

                              FirebaseFirestore.instance
                                  .collection("Confession")
                                  .doc(snapshot.data!
                                  .docs[index]["post"])
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
                                    .hand_thumbsup,),
                                Text(
                                  snapshot
                                      .data!.docs[index]["like"]
                                      .toString(),
                                )
                              ],
                            ),
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
      ),
    );
  }
}
