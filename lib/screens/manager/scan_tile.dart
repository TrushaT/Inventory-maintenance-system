import 'package:flutter/material.dart';
import 'package:inventory_management/models/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/models/user.dart';

class ScanTile extends StatelessWidget {
  final Scan scan;
  ScanTile({this.scan});

@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(scan.employee_name
              .toString()), // TODO: Also mention Product Name and etc. & On click of Product view details
          subtitle: Text(scan.scandate.toDate().toString().substring(0, 19)),
        ),
      ),
    );
  }
}
