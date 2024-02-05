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
 requestPermission()async{
   FirebaseMessaging messaging = FirebaseMessaging.instance;

   NotificationSettings settings = await messaging.requestPermission(
     alert: true,
     announcement: false,
     badge: true,
     carPlay: false,
     criticalAlert: false,
     provisional: false,
     sound: true,
   );

   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
     print('User granted permission');
   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
     print('User granted provisional permission');
   } else {
     print('User declined or has not accepted permission');
   }

 }
 void initState() {
   super.initState();

   WidgetsBinding.instance!.addPostFrameCallback((_) {
     getToken();
     requestPermission();

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
