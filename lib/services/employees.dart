import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/models/service.dart';
import 'package:inventory_management/models/user.dart';

class EmployeeService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference serviceCollection =
      FirebaseFirestore.instance.collection('Services');
  List<Inventory_User> employee_list = [];
  List<Service> service_list = [];

  List<Inventory_User> _userFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      if (doc.data()['user_type'] == "employee") {
        return Inventory_User(
            uid: doc.data()['uid'],
            name: doc.data()['name'],
            user_type: doc.data()['user_type'],
            date_of_joining: doc.data()['date_of_joining'],
            department: doc.data()['department'],
            mobile_number: doc.data()['mobile_number'],
            email: doc.data()['email']);
      }
    }).toList();
  }

  Stream<List<Inventory_User>> get employees {
    return userCollection.snapshots().map(_userFromSnapshot);
  }

  Future<List<Service>> getServices(userId) async {
    await serviceCollection
        .where("uid", isEqualTo: userId)
        .get()
        .then((value) => value.docs.forEach((doc) {
              service_list.add(Service(
                  doc.data()["uid"],
                  doc.data()["product_id"],
                  doc.data()["cost"],
                  doc.data()["date_of_service"],
                  doc.data()["description"],
                  doc.documentID,
                  doc.data()["productType"],
                  doc.data()["status"]));
            }));
    return service_list;
  }

  Future<List<Inventory_User>> getEmployees(department) async {
    await userCollection
        .where("user_type", isEqualTo: "employee")
        .where("department", isEqualTo: department)
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element);
              employee_list.add(Inventory_User(
                  uid: element.data()['uid'],
                  name: element.data()['name'],
                  user_type: element.data()['user_type'],
                  date_of_joining: element.data()['date_of_joining'],
                  department: element.data()['department'],
                  mobile_number: element.data()['mobile_number'],
                  email: element.data()['email']));
            }));
    return (employee_list);
  }

// name, user_type, date_of_joining, department, mobile_number,email
  Future updateUserData(
      {String uid,
      String name,
      String user_type,
      Timestamp date_of_joining,
      String department,
      String mobile_number,
      String email}) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'user_type': user_type,
      'date_of_joining': date_of_joining,
      'department': department,
      'mobile_number': mobile_number,
      'email': email
    });
  }
}
