import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Catigories/Add.dart';
import 'package:firebase/note/Add%20note.dart';
import 'package:firebase/note/Edit%20note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NoteView extends StatefulWidget {
  final String categoryid;
  const NoteView({Key? key, required this.categoryid});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categoryid)
        .collection("note")
        .get();

    data.addAll(querySnapshot.docs);
    setState(() {});
    isloading = false;
  }

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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Addnote(docid: widget.categoryid)));
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Note"),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                GoogleSignIn googleSignIn = GoogleSignIn();
                await googleSignIn.disconnect();

                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCategory()),
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Editnote(
                            notedocid: data[index].id,
                            Categorydocid: widget.categoryid,
                            Value: data[index]['note'])));
                  },
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'هل انتا متاكد من عمليه الحذف',
                      btnCancelText: "حذف",
                      btnOkOnPress: (){},
                      btnOkText: "الغاء",
                      btnCancelOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection("categories")
                            .doc(widget.categoryid).collection("note").doc(data[index].id)
                            .delete();
                     if(data[index]["url"]!="none"){
                       FirebaseStorage.instance.refFromURL(data[index]["url"]).delete();

                     }

                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoteView(categoryid: widget.categoryid,)));
                      },
    ).show();

                  },
                  child: Card(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text("${data[index]['note']}"),
                            if(data[index]["url"] != "none")
                              Image.network(
                                data[index]["url"],
                                height: 100, // Set a specific height for the image
                                width: 100,  // Set a specific width for the image
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                );
              },
            ),
    );
  }
}
