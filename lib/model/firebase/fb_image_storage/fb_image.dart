import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

class FirbeaseStorageImage{

//---------------------------
// TO SEND  IMAGE TO FIREBASE
//---------------------------

Future<String> uploadImage(String imageFile) async {
  Reference storageReference = FirebaseStorage.instance
      .ref();
  
      String mName=DateTime.now().toString()+Random(2).toString();
      String fileName='movieImage/$mName.jpg';
      Reference reference =storageReference.child(fileName);
      TaskSnapshot upload =await reference.putFile(File(imageFile));

  //  String url=await upload.ref.getDownloadURL();
  return await upload.ref.getDownloadURL();
}

//-------------------------------------
// TO REMOVE  IMAGE FROM FIREBASE
//-------------------------------------
 

Future<void> deleteImage(String imageUrl) async {
  Reference storageReference = FirebaseStorage.instance.refFromURL(imageUrl);
  await storageReference.delete();
}

}