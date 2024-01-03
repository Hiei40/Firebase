import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({super.key, required this.hinttext, required this.mycontroller});
final String hinttext;
final TextEditingController mycontroller;

@override
  Widget build(BuildContext context) {
    return   TextFormField(
controller: mycontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Color.fromARGB(255, 184, 184, 184)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Color.fromARGB(255, 190, 190, 190)),
        ),
      ),
    ) ;
  }
}
