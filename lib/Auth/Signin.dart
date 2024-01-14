import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/CustomButtonAuth.dart';
import '../Components/TextFormField.dart';
import '../Components/customlogoauth.dart';

class SignUp extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController password = TextEditingController();

  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              const CustomLogoAuth(),
              Container(height: 20),
              const Text("SignUp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("SignUp To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "Enter Your username", mycontroller: username, validator: (String? value) {  },),
              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "Enter Your Email", mycontroller: Email, validator: (String? value ) {  },),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "Enter Your Password", mycontroller: password, validator: (String? value) {  },),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Custombuttonauth(
            Title: "SignUp",
            onPressed: () async {
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: Email.text,
                  password: password.text,
                );
                Navigator.of(context).pushReplacementNamed("homePage");
              } on FirebaseAuthException catch (e) {
                if (e.code == 'email-already-in-use') {
                  print("The email address is already in use by another account.");
                } else if (e.code == 'weak-password') {
                  print("The password provided is too weak.");
                } else {
                  print("Error: ${e.message}");
                  Navigator.of(context).pushReplacementNamed("homePage");

                }
              } catch (e) {
                print("Error: $e");
              }
            },
          ),

          Container(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("login");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
