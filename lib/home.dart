import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepaliteenagersconfession/Createpost.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nepaliteenagersconfession/confessionpost.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<confession> datalist = [];


coming(){
  DatabaseReference reference = FirebaseDatabase.instance.reference().child("Confession");
  reference.once().then((DataSnapshot snapshot) {
    datalist.clear();
    var keys = snapshot.value.keys;
    var value = snapshot.value;
    for (var key in keys) {
      var data = confession(
          value[key]["description"],
          value[key]["Time"],
          value[key]["post"]

      );

      datalist.add(data);
    }
    setState(() {});
  });




}




  @override
  Widget build(BuildContext context) {
    coming();
    return Scaffold(
     floatingActionButton: GestureDetector(
       onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePost()));
       },
       child: Container(decoration: BoxDecoration(
         color: Colors.grey,
         shape: BoxShape.circle
       ),
         height: MediaQuery.of(context).size.height*0.05,
         width: MediaQuery.of(context).size.width*0.1,
         child: Icon(CupertinoIcons.pencil_outline,color: Colors.white,),
       ),
     ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepOrange
          ),
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.only(top: 50),
               child: Container(
                 height: MediaQuery.of(context).size.height*0.15,
                 width: MediaQuery.of(context).size.height*0.5,
                 decoration: BoxDecoration(
                     image: DecorationImage(
                         image: AssetImage("assets/giveone.png")
                     ),
                     color: Colors.deepOrange,
                     shape: BoxShape.circle
                 ),
               ),
             ),

           Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Text("Nepalese Teenagers Confession",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.share,color: Colors.white,),
              )
            ],
          ),
        ),
           ],
         ),

        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
            backgroundColor: Colors.deepOrange,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background:SafeArea(
                child: Container(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.height*0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/giveone.png")
                            ),
                              color: Colors.deepOrange,
                              shape: BoxShape.circle
                          ),
                      ),


                      Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Nepalese Teenagers Confession",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        offset: (Offset(0,5,)
                        ),
                        color: Colors.grey
                      )]


                    ),

                    width: MediaQuery.of(context).size.width*1,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5,top: 5),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.05,
                                      width: MediaQuery.of(context).size.height*0.05,
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        shape: BoxShape.circle
                                      ),
                                      child: Image(image: AssetImage("assets/giveone.png"))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("Nepalese Teenagers Confession",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
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
                                 padding: const EdgeInsets.only(top:55,left: 120,bottom: 30),
                                 child: Text(datalist[index].description),
                               )),




                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(     height: MediaQuery.of(context).size.height*0.04,
                                  width: MediaQuery.of(context).size.height*0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 0.1,color: Colors.grey)
                                  ),
                                  child: Icon(CupertinoIcons.hand_thumbsup),
                                ),
                              ),

                              Container(
                                height: MediaQuery.of(context).size.height*0.04,
                                width: MediaQuery.of(context).size.height*0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 0.1,color: Colors.grey)

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(CupertinoIcons.chat_bubble_2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.04,
                                  width: MediaQuery.of(context).size.height*0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 0.1,color: Colors.grey)
                                  ),
                                  child: Icon(Icons.share),
                                ),
                              ),


                            ],
                          ),
                        ),

                      ],
                    ),),
                );
              },
              childCount: datalist.length,
            ),
          ),
        ],
      ),
    );
  }
}
