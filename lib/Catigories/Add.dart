import 'package:firebase/Components/CustomButtonAuth.dart';
import 'package:firebase/Components/TextFormField.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState>globalKey=GlobalKey<FormState>();
TextEditingController name=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addcategory"),
      ),
      body: Form(
        key: globalKey, child:Column(
        children: [

          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,
              horizontal: 25 ),
              child: CustomTextForm(hinttext: "ادخل", mycontroller: name, validator: (String?Value){
                if(Value==""){
                  return"can\' t be empty ";
                }

              }),
            ),
          ),
         Custombuttonauth(onPressed: (){}, Title: "add")
        ],
      ),


      ),

    );
  }
}
