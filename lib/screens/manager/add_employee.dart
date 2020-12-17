import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Add"),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,

      ),
      body: Text("Add employee"),
    );
  }
}
