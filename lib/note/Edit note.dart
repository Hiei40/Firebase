import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Components/CustomButtonAuth.dart';
import 'package:firebase/note/View.dart';
import 'package:flutter/material.dart';
class Editnote extends StatefulWidget {
  final String notedocid;
  final String Categorydocid;
  final String Value;

  Editnote({Key? key, required this.notedocid, required this.Categorydocid, required this.Value}) : super(key: key);

  @override
  State<Editnote> createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();

  TextEditingController nameController = TextEditingController(); // Move the controller outside the method
  bool isloading=false;
//SET -update
  //set-add

  void edidnote() async {
    CollectionReference Collectionnote =
    FirebaseFirestore.instance.collection('categories').doc(widget.Categorydocid).collection("note");

    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
       await Collectionnote.doc(widget.notedocid).update({
          "note": note.text,});
        isloading = false;
        setState(() {});
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
        NoteView(categoryid: widget.Categorydocid)
        ));

      } catch (e) {
        print('Error $e');
      }
    }
  }
  @override
  void initState() {
    note.text=widget.Value;
    // TODO: implement initState
    super.initState();
  }
  void dispose() {
    super.dispose();
    note.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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
              onPressed: edidnote,
              Title: 'edit',
            ),
          ],
        ),
      ),
    );
  }
}