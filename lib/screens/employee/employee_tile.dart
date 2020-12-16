import 'package:flutter/material.dart';
import 'package:inventory_management/models/user.dart';

class EmployeeTile extends StatelessWidget {
  final Inventory_User employee;
  EmployeeTile({this.employee});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(employee.name),
          subtitle: Text(employee.department),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blueAccent,
            child: Image.asset('assets/profile.jpg'),
          ),
        ),
      ),
    );
  }
}
