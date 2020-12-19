import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String userId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> data;

  @override
  void initState() {
    final User user = auth.currentUser;
    userId = user.uid;
    print('$userId');
    super.initState();
  }

  // Future getDocs() async {
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection("Services").where('uid', isEqualTo: userId).get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //     print(a);
  //   }
  // }

  void productDetails(String pId) {
    FirebaseFirestore.instance
        .collection('product')
        .doc(pId)
        .get()
        .then((DocumentSnapshot doc) {
      setState(() {
        data = doc.data();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Services')
          .where('uid', isEqualTo: userId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data.docs.map((document) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 5,
                child: Text("Title: " + document['product_id']),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
