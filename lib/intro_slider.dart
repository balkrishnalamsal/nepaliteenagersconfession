import 'package:flutter/material.dart';
import 'home.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/slide_object.dart';

class IntroSliderPage extends StatefulWidget {
  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  List<Slide> slides = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides.add(
      new Slide(
        title: "Got anyting to confess ??",
        description:
        "Feel free to confess anything without showing your identity!",
        pathImage: "assets/giveone.png",
      ),
    );
    slides.add(
      new Slide(
        title: "No hate spech,bullying",
        description: "Make sure that everyone feels safe. Bulling of any kind isn't allowed and degrading comments about anything such as race,religion,culture,sexual orientation,gender or identity will not be tolorated!",
        pathImage: "assets/giveone.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Respect everyone's privacy !!",
        description: "Do not include any name,numbers and emails while sharing your confession. Make this platform clean as much as possible!!",
        pathImage: "assets/giveone.png",
      ),
    );
    slides.add(
      new Slide(
        title: "No promotion or Spam!!",
        description: "Give more to this app than you take,self promotion,spam and irrelevant links aren't allowed",
        pathImage: "assets/giveone.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Let's get started!",
        description: "Open confession is good for SOUL",
        pathImage: "assets/giveone.png",
      ),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            margin: EdgeInsets.only(bottom: 160, top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width*0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/giveone.png")
                    ),
                    shape: BoxShape.circle,
                  )
                ),


                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    currentSlide.title!,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Text(
                    currentSlide.description!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.only(
                    top: 15,
                    left: 20,
                    right: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      backgroundColorAllSlides: Colors.green[700],
      renderSkipBtn: Text("Skip",style: TextStyle(color: Colors.white),),
      renderNextBtn: Text(
        "Next",
        style: TextStyle(color: Colors.white),
      ),
      renderDoneBtn: Text(
        "Done",
        style: TextStyle(color: Colors.white),
      ),
      colorDot: Colors.white,
      colorActiveDot: Colors.white,
      sizeDot: 8.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: this.renderListCustomTabs(),
      scrollPhysics: BouncingScrollPhysics(),
      hideStatusBar: false,
      onDonePress: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      ),
    );
  }
}