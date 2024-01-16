import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Components/CustomButtonAuth.dart';
import 'package:firebase/Components/TextFormField.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(); // Move the controller outside the method

  addUser() async {
    if (formState.currentState!.validate()) {
      try {
        DocumentReference response = await FirebaseFirestore.instance.collection('categories').add({
          'name': nameController.text,
        });

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
        title: Text('Add Category'),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 25,
                ),
                child: TextFormField(
                  controller: nameController, // Use the controller for the TextFormField
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
              onPressed: addUser,
             Title: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}