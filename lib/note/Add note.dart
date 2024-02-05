import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Components/CustomButtonAuth.dart';
import 'package:firebase/Components/Custombuton%20upload.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class Addnote extends StatefulWidget {
  final String docid;

  Addnote({Key? key, required this.docid}) : super(key: key);

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();

  TextEditingController nameController = TextEditingController(); // Move the controller outside the method
  bool isloading=false;
//SET -update
  //set-add
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
  void addnote(context) async {
    CollectionReference Collectionnote = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.docid)
        .collection("note");

    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});

        // Check if both note and file are not null before proceeding
        if (note.text.isNotEmpty && file != null) {
          var imagename = basename(file!.path);
          var refStorage =
          FirebaseStorage.instance.ref("images").child(imagename);
          await refStorage.putFile(file!);

          url = await refStorage.getDownloadURL();

          // Add both note and image URL to Firestore
          await Collectionnote.add({
            "note": note.text,
            "url": url,
          });

          isloading = false;
          setState(() {});
          Navigator.of(context).pushReplacementNamed('homePage');
        } else {
          // Handle case where note or file is null
          // You can show an error message or take appropriate action
        }
      } catch (e) {
        print('Error $e');
      }
    }
  }

  void dispose() {
    super.dispose();
    note.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Form(
        key: formState,
        child: isloading?Center(child: CircularProgressIndicator(),):Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 25,
                ),
                child: TextFormField(
                  controller: note, // Use the controller for the TextFormField
                  decoration: InputDecoration(
                    hintText: 'Enter Your note',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            Custombuttonupload(onPressed: (){
              getImage();
            }, Title: "upload Image", Isselected: url==null?false:true,),
            Custombuttonauth(
              onPressed: () => addnote(context),
              Title: 'Add',
            ),

          ],
        ),
      ),
    );
  }
}