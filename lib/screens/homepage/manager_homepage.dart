import 'package:flutter/material.dart';

class ManagerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Portal'),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
      ),
      body: Container(
        child: Text('MANAGER PORTAL'),
      ),
    );
  }
}
