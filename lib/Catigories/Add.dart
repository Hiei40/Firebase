import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Components/CustomButtonAuth.dart';
import 'package:firebase/Components/TextFormField.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState>formState=GlobalKey<FormState>();
TextEditingController name=TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return categories
        .add({
      'name': name.text,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addcategory"),
      ),
      body: Form(
        key: formState, child:Column(
        children: [

          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,
              horizontal: 25 ),
              child: CustomTextForm(hinttext: "Enter Name", mycontroller: name, validator: (String?Value){
                if(Value==""){
                  return"can\' t be empty ";
                }
                else
                  {
                    return null;
                  }

              }),
            ),
          ),
         Custombuttonauth(onPressed: (){
           addUser();

         }, Title: "add")
        ],
      ),


      ),

    );
  }
}
