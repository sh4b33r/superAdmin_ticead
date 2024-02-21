import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:superadmin_ticead/controller/addmovie_cntrl/addmovie_cntrl.dart';
import 'package:superadmin_ticead/model/firebase/fb_image_storage/fb_image.dart';
import 'package:superadmin_ticead/model/movie_model/movie_model.dart';
import 'package:superadmin_ticead/view/addscreen/widget/custom_form.dart';
import 'package:superadmin_ticead/view/themes/texttheme.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cntroller = Get.put(AddController());
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Add Movie',
              style: MytextTheme.headerText,
            ),
            backgroundColor: Colors.black),
        body: Form(
          key: cntroller.formkey,
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomFormFiled(
                labelText: 'Name of Movie',
                icon: const Icon(Icons.movie),
                cntrl: cntroller.nameCntrl,
                validatortext: 'Name',
              ),

              CustomFormFiled(
                labelText: 'Description About Movie',
                validatortext: 'Movie Description',
                icon: const Icon(Icons.segment),
                maxLinesbool: true,
                cntrl: cntroller.descCntrl,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        ' Give Rating \n Percentage of Movie :',
                        style: MytextTheme.s15Text,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, top: 10),
                      child: CustomFormFiled(
                        validatortext: 'Rating',
                        labelText: 'Give Rating',
                        icon: const Icon(Icons.star_border),
                        cntrl: cntroller.ratingCntrl,
                        maxLengthbool: true,
                        keyboardTypebool: true,
                      ),
                    ),
                  ),
                ],
              ),

              // droddown
              // ----------------------------------------------------------------------
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 205, 243, 205),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none)),
                    hint: Text('Select Movie Genre'),
                    items: cntroller.genres
                        .map((element) => DropdownMenuItem(
                              value: element,
                              child: Text(element),
                            ))
                        .toList(),
                    menuMaxHeight: 250,
                    onChanged: (value) {
                      cntroller.selectedGenre.value = value.toString();
                      log(cntroller.selectedGenre.toString());
                    },
                  )),

              // droddown
              // ========================================================================================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        cntroller.pickImage(forBackdrop: true);
                      },
                      child: const Text('Pick Backdrop Image')),
                  const SizedBox(height: 10),
                  GetX<AddController>(builder: (controller) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(1, 2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              color: Colors.black),
                        ],
                        color: const Color.fromARGB(255, 239, 249, 223),
                      ),
                      height: MediaQuery.of(context).size.height * .20,
                      width: MediaQuery.of(context).size.width * .65,
                      child: controller.backDropImage.isEmpty
                          ? Lottie.asset(
                              'asset/lottie/Animation - 1708420541041.json')
                          : Image.file(File(controller.backDropImage.value)),
                    );
                  })
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        cntroller.pickImage();
                        await FirbeaseStorageImage()
                            .uploadImage(cntroller.posterIMage.value);
                      },
                      child: const Text('Pick Poster Image')),
                  const SizedBox(height: 10),
                  GetX<AddController>(builder: (controller) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(1, 2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              color: Colors.black),
                        ],
                        color: const Color.fromARGB(255, 239, 249, 223),
                      ),
                      height: MediaQuery.of(context).size.height * .20,
                      width: MediaQuery.of(context).size.width * .40,
                      child: controller.posterIMage.isEmpty
                          ? Lottie.asset(
                              'asset/lottie/Animation - 1708420541041.json')
                          : Image.file(File(controller.posterIMage.value)),
                    );
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 87, 196, 150),
                          Color.fromARGB(255, 48, 163, 77),
                          Color.fromARGB(255, 10, 146, 44),
                        ])),
                    child: ElevatedButton.icon(

                      
                      onPressed: () async {
                        String posterurl = await FirbeaseStorageImage()
                            .uploadImage(cntroller.posterIMage.value);
                        String backdropurl = await FirbeaseStorageImage()
                            .uploadImage(cntroller.backDropImage.value);
                        MovieModel movies = MovieModel(
                            name: cntroller.nameCntrl.text,
                            descripiton: cntroller.descCntrl.text,
                            rating: int.parse(cntroller.ratingCntrl.text),
                            genres: cntroller.selectedGenre.value,
                            backDrop: backdropurl,
                            poster: posterurl);
                        cntroller.movieHelper(movies);
                      }
                      
                      ,
                      icon: const Icon(
                        Icons.arrow_outward_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Submit',
                        style: MytextTheme.commomwhiteText,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
