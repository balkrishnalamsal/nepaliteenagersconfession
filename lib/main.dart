import 'package:flutter/material.dart';
import 'home.dart';
import 'intro_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences preferences;

  shared()async{
    preferences =await SharedPreferences.getInstance();
    String? value;
    value= preferences.getString("intro");

    debugPrint(value);
    if(value=="True"){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );

    }


  }

  @override
  void initState() {
    shared();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroSliderPage(),
    );
  }
}