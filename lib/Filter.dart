import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class FilterFirestore extends StatefulWidget {
  const FilterFirestore({Key? key}) : super(key: key);

  @override
  State<FilterFirestore> createState() => _FilterFirestoreState();
}

class _FilterFirestoreState extends State<FilterFirestore> {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  File? file;
  String? url;


  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);


      file = File(photo!.path);
      var imagename=basename(photo.path);
      var refStorage = FirebaseStorage.instance.ref("images").child(imagename);
      await refStorage.putFile(file!); // This line was missing in your code
   url=await refStorage.getDownloadURL();
      setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Container(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () async {
                await getImage();
              },
              child: Text("Get Image Camera"),
            ),
            if (url != null)
              Image.network(
                url!,
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              )
          ],
        ),
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
