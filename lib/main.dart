import 'package:firebase/Auth/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Auth/Signin.dart';
import 'Catigories/Add.dart';
import 'Filter.dart';
import 'Auth/firebase_options.dart';
import 'HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp.init());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Initialization logic can be done in the constructor
  MyApp.init() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
appBarTheme: AppBarTheme(
  backgroundColor: Colors.grey[50],
  titleTextStyle: TextStyle(color: Colors.orange,fontSize: 17,fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(
    color: Colors.orange,
)
),
      ),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.emailVerified)
          ? HomePage()
          : Login(),


    routes: {
      "signup": (context) => SignUp(),
      "login": (context) => Login(),
      "homePage": (context) => HomePage(), // Make sure this is defined
      "addcategory": (context) => AddCategory(),
      "FilterFirestore": (context) => FilterFirestore(),
    }

   );

  }
}

