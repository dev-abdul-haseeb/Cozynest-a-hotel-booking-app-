import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/loginScreen.dart';
import 'Functions/TextStyles.dart';

class splashScreeen extends StatefulWidget {
  @override
  State<splashScreeen> createState() => _splashScreeenState();
}

class _splashScreeenState extends State<splashScreeen>
    with SingleTickerProviderStateMixin {
  bool _showLogo = false;
  bool _showSlogan = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 500), () {
      setState(() {
        _showLogo = true;
      });
    });

    Future.delayed(Duration(milliseconds: 2700), () {
      setState(() {
        _showSlogan = true;
      });
    });

    Future.delayed(Duration(milliseconds: 5500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    double headings = screenHeight * 0.07;
    double simpleFont = headings * 0.3;
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade100],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_showLogo)
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'CozyNest',
                        textStyle: LogoHead(headings),
                        speed: Duration(milliseconds: 250),
                        cursor: '',
                      ),
                    ],
                  ),
                SizedBox(height: screenHeight*0.005),
                AnimatedOpacity(
                  opacity: _showSlogan ? 1.0 : 0.0,
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  child: Container(
                    height: screenHeight*0.04,
                    width: screenWidth * 0.7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade200,
                          Colors.green.shade400,
                          Colors.green.shade200,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Your Nest Away From Home',
                        style: slogan(simpleFont),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Colors.blue.shade400,Colors.blue.shade200,Colors.blue.shade400
//Color(0xff319a71), Color(0xffafe6c9)
