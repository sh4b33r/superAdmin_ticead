import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:superadmin_ticead/view/addscreen/add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => const AddScreen());
          },
          label: const Text("Add Movie")),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Movie').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: SlidableAutoCloseBehavior(
                    closeWhenOpened: true,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Slidable(
                            key: ValueKey(index),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (_) {
                                    Get.defaultDialog(
                                        title: 'Delete Item',
                                        content: const Text(
                                            "Are You Sure You Want to Deleted"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('Movie')
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .delete();
                                              Get.back();
                                            },
                                            child: const Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('No'),
                                          ),
                                        ]);
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {},
                                  backgroundColor: const Color(0xFF0392CF),
                                  foregroundColor: Colors.white,
                                  icon: Icons.save,
                                  label: 'Edit',
                                ),
                              ],
                            ),
                            child: Container(
                              color: Colors.amberAccent,
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Text(snapshot.data!.docs[index]['name']),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (!snapshot.hasData) {
                log('ELse if keeri');
                return Center(
                    child: Lottie.asset(
                        'asset/lottie/Animation - 1708521086022.json',
                        height: 300,
                        width: 300));
              } else {
                log('ELse keeri');
                return Center(
                    child: Lottie.asset(
                        'asset/lottie/Animation - 1708420541041.json',
                        height: 300,
                        width: 300));
              }
            },
          ),
        ],
      ),
    );
  }
}
