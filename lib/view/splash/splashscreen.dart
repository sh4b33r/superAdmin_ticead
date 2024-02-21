import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:superadmin_ticead/controller/splash_cntrl/splash_cntrl.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashCntrl());
      return Scaffold(

    body: Center(
      child: SizedBox(
 
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset('asset/lottie/Animation - 1708420541041.json',height:MediaQuery.of(context).size.height,width:MediaQuery.of(context).size.width  ),
      
      ),
    ),


    );
  }
}