import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Catigories/Add.dart';
import 'package:firebase/Catigories/Edit.dart';
import 'package:firebase/note/View.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Auth/Login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get(); // Use get() to retrieve the data

    data = querySnapshot.docs;
    setState(() {});
    isloading = false;
    await Future.delayed(Duration(seconds: 1));
  }

  var x=0;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("addcategory");
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("FireBase"),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                      (Route<dynamic> route) => false,
                );
              } catch (e) {
                print("Error during logout: $e");
                // Handle the error, show a message, or take appropriate action.
              }
            },
            icon: Icon(Icons.exit_to_app),
          )

        ],
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 250,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoteView(categoryid:data[index].id,)));
                  },
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'اختر ماذا تريد',
                      btnCancelText: "حذف",
                      btnCancelOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection("categories")
                            .doc(data[index].id)
                            .delete();
                        Navigator.of(context).pushReplacementNamed("homePage",
                        arguments: x.toString());
                      },
                      btnOkText: "تحديث",
                      btnOkOnPress: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditCategory(
                              docid: data[index].id,
                              oldname: data[index]['name'],
                            ),
                          ),

                        );
                      },
                    )..show();
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "Image/kisspng-emoji-file-folders-directory-computer-icons-txt-file-5acd8ad8c2a790.3510068315234198647973.png",
                            ),
                          ),
                        ),
                        Text("${data[index]['name']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
