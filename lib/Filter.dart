import 'dart:html';

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
getImage()async{

  final ImagePicker picker = ImagePicker();
// Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
// Pick a video.
  final XFile? galleryVideo =
      await picker.pickVideo(source: ImageSource.gallery);
// Capture a video.
  final XFile? cameraVideo = await picker.pickVideo(source: ImageSource.camera);
// Pick multiple images.
  final List<XFile> images = await picker.pickMultiImage();
// Pick singe image or video.
  final XFile? media = await picker.pickMedia();
// Pick multiple images and videos.
  final List<XFile> medias = await picker.pickMultipleMedia();


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading....");
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    DocumentReference documentReference = FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(snapshot.data!.docs[index].id);
                    FirebaseFirestore.instance
                        .runTransaction((transaction) async {
                      DocumentSnapshot snapshot =
                          await transaction.get(documentReference);
                      if (snapshot.exists) {
                        var snapshotData = snapshot.data();
                        if (snapshotData is Map<String, dynamic>) {
                          int money = snapshotData['money'] + 100;
                          transaction
                              .update(documentReference, {"money": money});
                        }
                      }
                    }).then((value) {
// Navigator.of(context).pushAndRemoveUntil(
// MaterialPageRoute(builder: (context) => FilterFirestore()),
// (route) => false);
                    });
                  },
                  child: Card(
                    child: ListTile(
                      trailing: Text(
                          "Money: ${snapshot.data!.docs[index]['money']}\$"),
                      subtitle:
                          Text("Age: ${snapshot.data!.docs[index]['age']}"),
                      title: Text(
                        snapshot.data!.docs[index]['username'],
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                );
              },
            );
          },
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
