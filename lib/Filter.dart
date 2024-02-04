// import 'dart:html';
import 'dart:io'; // Add this line

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FilterFirestore extends StatefulWidget {
  const FilterFirestore({Key? key}) : super(key: key);

  @override
  State<FilterFirestore> createState() => _FilterFirestoreState();
}

class _FilterFirestoreState extends State<FilterFirestore> {
  final Stream<QuerySnapshot> usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();
  File? file;

  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      file = File(photo!.path);
      setState(() {});
   }
  // File _image;
  // final ImagePicker _picker = ImagePicker();
  // Future getImage() async {
  //   var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Container(
        child: Column(children: [
          MaterialButton(onPressed: ()async{
           await getImage();
          },child: Text("Get Image Camera"),),

        ],)
      ),
    );
  }
}

// documentReference.update({"money": data[index]["money"] + 100});
// FirebaseFirestore.instance.runTransaction((transaction) async {
// DocumentSnapshot snapshot = await transaction.get(documentReference);
// if (snapshot.exists) {
// var snapshotData = snapshot.data();
// if (snapshotData is Map<String, dynamic>) {
// int money = snapshotData['money'] + 100;
// transaction.update(documentReference, {"money": money});
// }
// }
// }).then((value) {
// Navigator.of(context).pushAndRemoveUntil(
// MaterialPageRoute(builder: (context) => FilterFirestore()),
// (route) => false);
// });
