import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
 getToken()async{
   String? mytoken=await FirebaseMessaging.instance.getToken();
   print("================");
print(mytoken);
 }
 void initState() {
   super.initState();
   WidgetsBinding.instance!.addPostFrameCallback((_) {
     getToken();
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(),



    );
  }
}
