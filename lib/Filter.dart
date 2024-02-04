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
    QuerySnapshot userdata = await users.orderBy("age", descending: true).get();
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
              onTap: () {
                 DocumentReference documentReference =
                 FirebaseFirestore.instance.collection('users').doc(data[index].id);
                 // documentReference.update({"money": data[index]["money"] + 100});
                 FirebaseFirestore.instance.runTransaction((transaction) async {
                   DocumentSnapshot snapshot = await transaction.get(documentReference);
                   if (snapshot.exists) {
                     var snapshotData = snapshot.data();
                     if (snapshotData is Map<String, dynamic>) {
                       int money = snapshotData['money'] + 100;
                       transaction.update(documentReference, {"money": money});
                     }
                   }
                 }).then((value) {
                   Navigator.of(context).pushAndRemoveUntil(
                       MaterialPageRoute(builder: (context) => FilterFirestore()),
                           (route) => false);
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
