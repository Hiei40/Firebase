import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Components/CustomButtonAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  void dispose() {
    super.dispose();
    note.dispose();
  }
  void addnote() async {
    CollectionReference collectionnote =
    FirebaseFirestore.instance.collection('categories').doc(widget.docid).collection("note");

    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        DocumentReference response = await collectionnote.add({
          'note': note.text,
          "id": FirebaseAuth.instance.currentUser!.uid,
          "user": FirebaseAuth.instance.currentUser!.displayName,
        });
        isloading = false;
        setState(() {});
        Navigator.of(context).pushReplacementNamed('homePage');
        print(response);
      } catch (e) {
        print('Error $e');
      }
    }
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
            Custombuttonauth(
              onPressed: addnote,
              Title: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}