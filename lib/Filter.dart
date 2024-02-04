import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterFirestore extends StatefulWidget {
  const FilterFirestore({Key? key}) : super(key: key);

  @override
  State<FilterFirestore> createState() => _FilterFirestoreState();
}

class _FilterFirestoreState extends State<FilterFirestore> {
  List<DocumentSnapshot> data = [];

  Future<void> initialData() async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot userdata = await users.orderBy("age", descending: false).get();
    data = userdata.docs;
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
            return GestureDetector(
              onTap: (){
             CollectionReference users=FirebaseFirestore.instance.collection('users');
             DocumentReference doc1=FirebaseFirestore.instance.collection('users').doc('1');
             DocumentReference doc2=FirebaseFirestore.instance.collection('users').doc("2");

             WriteBatch batch=FirebaseFirestore.instance.batch();

batch.set(doc1, {
  "username":"mohamed",
  "money":120,
  "phone":"+12004545452",
  "age":"45"

});

             batch.set(doc2, {
               "username":"jkbk",
               "money":250,
               "phone":"+2004512215",
               "age":"50"

             });
              },
              child: Card(
                child: ListTile(
                  trailing: Text("Money: ${data[index]['money']}\$"),
                  subtitle: Text("Age: ${data[index]['age']}"),
                  title: Text(
                    data[index]['username'],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
