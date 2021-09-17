import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(
        child: Container(

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

                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width*1,
                    child: Stack(
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

                      ],
                    ),),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
