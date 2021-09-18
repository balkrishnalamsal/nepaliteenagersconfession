import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepaliteenagersconfession/AdminPanel.dart';
import 'package:nepaliteenagersconfession/Createpost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timestamp? iteam;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late FirebaseAuth currentuser;
  late SharedPreferences preferences;

  bool islogin = false;
  bool isloading = false;

  Future<void> isSignin() async {
    setState(() async {
      islogin = true;
    });

    preferences = SharedPreferences.getInstance() as SharedPreferences;
    islogin = await googleSignIn.isSignedIn();
    if (islogin) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          "Nepalese Teenagers Confession",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePost()));
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.1,
          child: Icon(
            CupertinoIcons.pencil_outline,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(color: Colors.deepOrangeAccent),
          child: Column(
            children: [
              GestureDetector(
                onDoubleTap: (){
                  controlSignIN();
                },
                child: Padding(
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
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Confession")
                  .orderBy("Time", descending: true)
                  .where("status", isEqualTo: "Approved")
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
                                      GestureDetector(
                                        onTap: (){

                                          int value= snapshot.data!.docs[index]["like"];
                                          value=value+1;


                                          FirebaseFirestore.instance
                                              .collection("Confession")
                                              .doc(snapshot.data!.docs[index]["post"]).update(
                                              {
                                                "like":value,
                                              });
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
                                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                    CupertinoIcons.hand_thumbsup),
                                                Text(snapshot.data!.docs[index]["like"].toString(),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
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
      ),
    );
  }

  Future<Null> controlSignIN() async {
    preferences = await SharedPreferences.getInstance();
    GoogleSignInAccount? googleuser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleuser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    User? firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      final QuerySnapshot resutquery = await FirebaseFirestore.instance
          .collection("profile")
          .where("userrid", isEqualTo: firebaseUser.uid)
          .get();

      final List<DocumentSnapshot> documentsnapshot = resutquery.docs;

      //Save data to firestore -if new user
      if (documentsnapshot.length == 0) {
        String postid = Uuid().v4();
        FirebaseFirestore.instance
            .collection("profile")
            .doc(firebaseUser.uid)
            .set({
          "nickname": firebaseUser.displayName,
          "photourl": firebaseUser.photoURL,
          "userrid": firebaseUser.uid,
          "email": firebaseUser.email,
          "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
          "unique": postid,
        });

        //Write data to local
        currentuser = firebaseAuth;
        await preferences.setString("email", currentuser.currentUser!.email!);
        await preferences.setString("id", currentuser.currentUser!.uid);
        await preferences.setString("unique", postid);
        await preferences.setString(
            "nickname", currentuser.currentUser!.displayName!);
        await preferences.setString(
            "photourl", currentuser.currentUser!.photoURL!);
      } else {
        currentuser = firebaseAuth;
        await preferences.setString("email", documentsnapshot[0]["email"]);
        await preferences.setString("id", documentsnapshot[0]["userrid"]);
        await preferences.setString("unique", documentsnapshot[0]["unique"]);
        await preferences.setString(
            "nickname", documentsnapshot[0]["nickname"]);
        await preferences.setString(
            "photourl", documentsnapshot[0]["photourl"]);
      }

      this.setState(() {
        isloading = false;

        String? value = preferences.getString("email");
        if (value == "adwinlamal@gmail.com" ||
            value == "balkrishnalamsal12@gmail.com" ||
            value == "balkrishnalamsal1@gmail.com") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Adminpanel()));
        } else {
          Fluttertoast.showToast(
            msg: 'Not available',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.orange,
            textColor: Colors.black,
          );
        }
      });
    } else {
      Fluttertoast.showToast(msg: "login Failed");
      this.setState(() {});
    }
  }
}
