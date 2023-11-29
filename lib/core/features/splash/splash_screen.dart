import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtec_task/core/features/home/vidoe_screen.dart';
import 'package:qtec_task/core/utils/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    checkAuthState();

    super.initState();
  }

void checkAuthState() async {

  Timer(Duration(seconds: 3), () {

    Get.offAll(() => HomeScreen());

  });

}



@override
  Widget build(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor:colorScheme.surfaceVariant,
        body:Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  height:300,
                  child: Lottie.asset("assets/animation/video_ani.json")
              ),
              Text("Qtec Solution Limited",style: TextStyle(fontSize: 18,color: HexColor('#855EA9'),fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}

