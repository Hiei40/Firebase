import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireBase"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: ListView(
        children: [
          (FirebaseAuth.instance.currentUser!.emailVerified)
              ? Text('Welcome')
              : MaterialButton(
                  child: Text(
                    'please Verfied Email',
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  },
                  color: Colors.blue,
                ),
        ],
      ),
    );
  }
}
