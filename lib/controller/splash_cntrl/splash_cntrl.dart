import 'package:get/get.dart';
import 'package:superadmin_ticead/view/home/homscreen.dart';

class SplashCntrl extends GetxController{


@override
 void onInit() {
    intro();
    super.onInit();
  }

 intro(){
   
 Future.delayed(const Duration(seconds: 5), () { 
  Get.offAll(() => const HomeScreen());
});

 }







}