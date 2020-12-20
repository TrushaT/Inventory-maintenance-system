import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/screens/admin/add_manager.dart';
import 'package:inventory_management/screens/authenticate/login.dart';
import 'package:inventory_management/services/auth.dart';

class AdminHomePage extends StatelessWidget {
  AuthService _auth = new AuthService();

  void showToast() {
    Fluttertoast.showToast(
        msg: 'You have been logged out',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Portal'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  showToast();
                  await _auth.signOut().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false));
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        body: Column(
          children: [
            Center(
              child: ButtonTheme(
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
                      ))),
            )
          ],
        ));
  }
}
