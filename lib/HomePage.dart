import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    data = querySnapshot.docs; // Use direct assignment instead of addAll
    setState(() {});
    isloading = false;
    await Future.delayed(Duration(seconds: 1));
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
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.disconnect();

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
                  onLongPress: (){
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'هل انتا متاكد من عمليه الحذف',
                      btnCancelOnPress: () {},
                      btnOkOnPress: ()async{
                        await FirebaseFirestore.instance.collection("categories").doc(data[index].id).delete();
                     Navigator.of(context).pushReplacementNamed("homePage");
                      },
                    ).show();
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
