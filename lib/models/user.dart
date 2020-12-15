import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory_User {
  final String uid;
  final String name;
  final String user_type;
  final Timestamp date_of_joining;
  final String department;
  final String mobile_number;
  final String email;
  Inventory_User(
      {this.uid,
      this.name,
      this.user_type,
      this.date_of_joining,
      this.department,
      this.mobile_number,
      this.email});
}
