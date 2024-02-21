import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:superadmin_ticead/model/movie_model/movie_model.dart';
import 'package:superadmin_ticead/view/themes/widgets_common.dart';

class FirebaseMovieBrigde{


 Future<void> sendMoviefb(MovieModel movie)async{
   
   
 final data=await FirebaseFirestore.instance.collection('Movie').add({
      'name': movie.name,
      'description': movie.descripiton,
      'rating': movie.rating,
      'genres': movie.genres,
      'backDrop': movie.backDrop,
      'poster': movie.poster,
    }).whenComplete(() =>Styles().c1sSnackbar(data: 'Data Added Succesfully', green: true) );
 
 }
 
}

//  FirebaseMovieBrigde firebaseMovieBridge = FirebaseMovieBrigde();
//     await firebaseMovieBridge.sendMoviefb();

// Future<void> sendMoviefb(MovieModel movie) async {
//     await FirebaseFirestore.instance.collection('Movie').add({
//       'name': movie.name,
//       'description': movie.descripiton,
//       'rating': movie.rating,
//       'genres': movie.genres,
//       'backDrop': movie.backDrop,
//       'poster': movie.poster,
//     });
//   }