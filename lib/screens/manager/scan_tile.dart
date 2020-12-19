import 'package:flutter/material.dart';
import 'package:inventory_management/models/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/models/user.dart';

class ScanTile extends StatelessWidget {
  final List scan;
  ScanTile({this.scan});

  User user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();

  Future<String> getname() async {
    dynamic u = await _auth.getUserData(scan[0].employee_id);
    return u.name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(scan[1]['name'].toString()),
          subtitle: Text(scan[0].scandate.toDate().toString().substring(0, 19)),
        ),
      ),
    );
  }
}
