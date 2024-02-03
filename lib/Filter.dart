import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FilterFirestore extends StatefulWidget {
  const FilterFirestore({Key? key}) : super(key: key);

  @override
  State<FilterFirestore> createState() => _FilterFirestoreState();
}

class _FilterFirestoreState extends State<FilterFirestore> {
  List<DocumentSnapshot> data = [];
  initialData() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot userdata = await users.where("Lang",arrayContains: "Ara").get();
    userdata.docs.forEach((element) {
      data.add(element);
    });
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    initialData();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                subtitle: Text("age:${data[index]['age']}",),
                title: Text(data[index]['username'],
                  style: TextStyle(fontSize: 30),
                ),

              ),
            );
          },
        ),
      ),
    );
  }
}
