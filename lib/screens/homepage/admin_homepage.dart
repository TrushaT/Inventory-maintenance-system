import 'package:flutter/material.dart';
import 'package:inventory_management/screens/admin/add_manager.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Portal'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              child: Text('ADMIN PORTAL'),
            ),
            ButtonTheme(
                minWidth: 200.0,
                height: 40.0,
                child: RaisedButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddManagerForm()),
                      );
                    },
                    child: Text(
                      'Add Manager',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    )))
          ],
        ));
  }
}
