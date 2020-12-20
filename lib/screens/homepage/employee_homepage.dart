import 'package:flutter/material.dart';
import 'package:inventory_management/screens/employee/form.dart';
import 'package:inventory_management/screens/employee/home.dart';
import 'package:inventory_management/screens/employee/scanner.dart';
import 'package:inventory_management/screens/employee/generate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_management/screens/employee/sheets.dart';

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

  final tabs = [
    Home(),
    Generate(),
    Scanner(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Panel"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0, top: 15.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Sheets()));
                },
                child: Icon(
                  Icons.assignment,
                  size: 30.0,
                ),
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
