import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> serviceSetup(
    String productid, String description, String cost, String date, String productType) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Services');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users.add({
    'product_id': productid,
    'description': description,
    'cost': cost,
    'date_of_service': date,
    "uid": uid,
    "productType":productType
  });
  return;
}
