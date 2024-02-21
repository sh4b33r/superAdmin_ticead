import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Styles{
c1sSnackbar({required String data,required bool green}){
    Get.showSnackbar( GetSnackBar(message: data, backgroundColor: green==true?Colors.green:Colors.red,isDismissible: true,duration: const Duration(seconds: 1),));
}




}