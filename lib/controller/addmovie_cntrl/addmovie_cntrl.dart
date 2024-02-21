import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superadmin_ticead/model/firebase/fb_movie_data/fb_movie.dart';
import 'package:superadmin_ticead/model/movie_model/movie_model.dart';

class AddController extends GetxController {
  GlobalKey<FormState> formkey=GlobalKey<FormState>();
  TextEditingController nameCntrl = TextEditingController();
  TextEditingController descCntrl = TextEditingController();
  Rx<String> backDropImage=''.obs;
    Rx<String>  posterIMage=''.obs;
  // RxString posterIMage=''.obs;
   RxBool isEditing = false.obs;
  TextEditingController ratingCntrl = TextEditingController();
  var language;
  bool imagebckloading=false;
  bool imagepsoterloading=false;
  RxString selectedGenre = ''.obs;
  //  RxSet<String> slectedGs=<String>{}.obs;
   Rx<String> slectedGs=''.obs;
  RxList<String> selecteditems = <String>[].obs;
  RxSet <String>genres ={
    'Action',
    'Drama',
    'Comedy',
    'Sci-Fi',
    'Horror',
    'Adventure',
    'Thriller',
    'Romance',
    'Crime',
    'Fantasy',
    'Animation',

  }.obs;

  setSelectedGenre(value){
        
  selectedGenre.value = value;

}
//--------------------------------------------------
// TO PICK IMAGE ACCORDING TO THE POSTER AND BACKDROP
//--------------------------------------------------
 
  
  Future pickImage({bool forBackdrop = false}) async {
    try {
      final imagepicked =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepicked == null) return;
      final imageTemp = imagepicked;
      if (forBackdrop) {
        backDropImage.value = imageTemp.path;
      } else {
        posterIMage.value = imageTemp.path;
      }

      
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }



  movieHelper(MovieModel movie)async{




      await FirebaseMovieBrigde().sendMoviefb(movie);
  }
}
