import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Auth/Login.dart';
import 'Catigories/Add.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategory()),
          );        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),

      ),
      appBar: AppBar(
        title: Text("FireBase"),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googlesignIn = GoogleSignIn();
              googlesignIn.disconnect();

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
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 250),
        children: [
          Card(
            child: Column(
              children: [
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                      "Image/kisspng-emoji-file-folders-directory-computer-icons-txt-file-5acd8ad8c2a790.3510068315234198647973.png"),
                )),
                Text("Company")
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                      "Image/kisspng-emoji-file-folders-directory-computer-icons-txt-file-5acd8ad8c2a790.3510068315234198647973.png"),
                )),
                Text("Home")
              ],
            ),
          ),
        ],
      ),
    );
  }
}