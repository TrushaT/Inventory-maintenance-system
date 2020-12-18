import 'package:flutter/material.dart';
import 'package:inventory_management/screens/employee/scanner.dart';
import 'package:inventory_management/screens/employee/generate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(MaterialApp(title: 'employee app', home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentindex = 0;
  final tabs = [
    Center(child: Text('Home')),
    Generate(),
    Scanner(),
  ];

  Future scanBarcode() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#fff666", "Cancel", true, ScanMode.QR)
        .then((value) => {
              print(value),
              setState(() {
                _currentindex = int.parse(value);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Panel"),
      ),
      body: tabs[_currentindex],
      floatingActionButton: FloatingActionButton(
        onPressed: scanBarcode,
        child: Icon(Icons.camera),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Add",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: "Camera",
              backgroundColor: Colors.blue),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}
