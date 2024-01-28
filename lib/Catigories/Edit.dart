import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/note/View.dart';
import 'package:flutter/material.dart';

import '../Components/CustomButtonAuth.dart';

class EditCategory extends StatefulWidget {
  final String docid;
  final String oldname;
  final String categoryid;

  const EditCategory({
    Key? key,
    required this.docid,
    required this.oldname,
    required this.categoryid,
  }) : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  TextEditingController nameController =
      TextEditingController(); // Move the controller outside the method
  bool isloading = false;

  editUser() async {
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        await categories
            .doc(widget.docid)
            .set({"name": nameController.text}, SetOptions(merge: true));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteView(categoryid: widget.categoryid)));
        isloading = false;
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homePage", (route) => false);
      } catch (e) {
        print('Error $e');
      }
    }
  }

  @override
  void initState() {

    nameController.text = widget.oldname;
    super.initState(); // Invoke the overridden method from the superclass
  }

  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Form(
        key: formState,
        child: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        controller:
                            nameController, // Use the controller for the TextFormField
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
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
                    onPressed: editUser,
                    Title: 'Edit',
                  ),
                ],
              ),
      ),
    );
  }
}
// Navigator.of(context).pushReplacementNamed('homePage');
