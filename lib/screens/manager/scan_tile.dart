import 'package:flutter/material.dart';
import 'package:inventory_management/models/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management/services/auth.dart';

class ScanTile extends StatelessWidget {
  final Scan scan;
  ScanTile({this.scan});

  User user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();

  Future getname() async {
  dynamic u = await _auth.getUserData(scan.employee_id);
  return u.name;
  
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(getname().toString()),
          subtitle: Text(scan.scandate.toString()),
        ),
      ),
    );
  }
}
