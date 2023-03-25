import 'dart:async';
import 'package:covid_tracker/Views/countries_list.dart';

import 'World_Stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller= AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
            ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> WorldStates()))
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(animation: _controller,
                child: Container(
                  height: 250,
                  width: 250,
                  child: const Center(
                    child: Image(image: AssetImage('images/virus.png')),
                  ),
                ),
                builder: (BuildContext context,Widget? child){
                  return Transform.rotate(
                    angle: _controller.value*2*math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height:MediaQuery.of(context).size.height*0.06,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Covid-19\n Tracker App",textAlign: TextAlign.center,style:
                  GoogleFonts.lato(fontSize: 35,fontWeight: FontWeight.bold),

                  ),
              ),
          ],
        ),
      ),
    );
  }
}
