import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/screens/authenticate/login.dart';
import 'package:inventory_management/screens/employee/form.dart';
import 'package:inventory_management/screens/employee/home.dart';
import 'package:inventory_management/screens/employee/scanner.dart';
import 'package:inventory_management/screens/employee/generate.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(MaterialApp(title: 'Employee App', home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentindex = 0;
  int pageproduct = 0;
  int pageservice = 0;
  AuthService _auth = new AuthService();

  final tabs = [
    Home(),
    Generate(),
    Scanner(),
  ];

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
        title: Text("Employee Panel"),
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
      body: tabs[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Add",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: "Scan",
              backgroundColor: Colors.blue),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
            pageproduct = 0;
            pageservice = 0;
          });
        },
      ),
    );
  }
}
