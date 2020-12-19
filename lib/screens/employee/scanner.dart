import 'package:flutter/material.dart';
import 'package:inventory_management/models/service.dart';
import 'package:inventory_management/screens/employee/serviceList.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import './product_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import './form.dart';
import 'package:inventory_management/services/auth.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  GlobalKey qrkey = GlobalKey();
  bool showProduct = false;
  var qrText = "";
  String dateAdded;

  Map<String, dynamic> data;
  CollectionReference users = FirebaseFirestore.instance.collection('product');
  CollectionReference service =
      FirebaseFirestore.instance.collection('Services');
  QRViewController controller;
  User user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();

  Future getdepartment() async {
  dynamic u = await _auth.getUserData(user.uid);
  return u.department;
  
  }
  List<Service> services;
  List<Service> services_local = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
            child: QRView(
                key: qrkey,
                overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderColor: Colors.red,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300),
                onQRViewCreated: _onQrViewCreate),
            flex: 5),
        Expanded(
            child: Center(
              child: Text('Scan Text: $qrText'),
            ),
            flex: 1),
        RaisedButton(
            onPressed: () {
              if (qrText != null) {
                users
                    .document(qrText.toString())
                    .get()
                    .then((DocumentSnapshot doc) {
                  if (doc.exists) {
                    FirebaseFirestore.instance.collection("ScanLog").add({
                      "scandate": Timestamp.fromDate(DateTime.now()),
                      "employee_id": user.uid,
                      "product_id": doc.id,
                    });
                    setState(() {
                      showProduct = true;
                    });
                    print(doc.data());
                    setState(() {
                      data = doc.data();
                    });
                    this.services_local = [];
                    service.getDocuments().then((QuerySnapshot snapshot) => {
                          snapshot.documents.forEach((DocumentSnapshot doc) {
                            if (doc.data()["product_id"] == qrText) {
                              this.services_local.add(new Service(
                                    doc.data()["uid"],
                                    doc.data()["product_id"],
                                    doc.data()["cost"],
                                    doc.data()["date_of_service"],
                                    doc.data()["description"],
                                    doc.documentID,
                                    doc.data()["productType"],
                                  ));
                            }
                          })
                        });
                  }
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return showProduct
                        ? Scaffold(
                            appBar: AppBar(
                                title: Text('Employee Pannel'),
                                actions: <Widget>[]),
                            body: SingleChildScrollView(
                              child: Container(
                                  child: Column(
                                children: [
                                  Container(
                                    child: Center(
                                      child: Text(
                                        "Product Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(30),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                      "Product Description  :",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(10),
                                    margin: EdgeInsets.fromLTRB(5, 15, 0, 0),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(data["description"],
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.justify),
                                    ),
                                    padding: const EdgeInsets.all(25),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                        "Product Status  :  " + data["status"],
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                        "Product Cost  :  " + data["cost"],
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                        "Product Added Date  : " +
                                            data["dateAdded"]
                                                .toDate()
                                                .toString(),
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                        "Waranty  : " +
                                            data["warranty"]
                                                .toDate()
                                                .toString(),
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                        "End of Life  : " +
                                            data["endOfLife"]
                                                .toDate()
                                                .toString(),
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                        "Next Service Date  : " +
                                            data["nextServiceDate"]
                                                .toDate()
                                                .toString(),
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                        "Product Type  : " +
                                            data["productType"],
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    child: Text(
                                        "Department  : " + data["department"],
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.justify),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(20),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: myBoxDecoration(),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                                    child: MaterialButton(
                                      height: 50.0,
                                      minWidth: 3 *
                                          MediaQuery.of(context).size.width /
                                          4,
                                      onPressed: () => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          print(qrText.toString());
                                          return MyCustomForm(qrText.toString(),
                                              data["productType"]);
                                        }))
                                      },
                                      color: Colors.white,
                                      child: Container(
                                        child: Text("Add Service"),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.green)),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                                    child: MaterialButton(
                                      height: 50.0,
                                      minWidth: 3 *
                                          MediaQuery.of(context).size.width /
                                          4,
                                      onPressed: () => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return ServiceList(
                                              this.services_local);
                                        }))
                                      },
                                      color: Colors.white,
                                      child: Container(
                                        child: Text("Display Service"),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.green)),
                                    ),
                                  )
                                ],
                              )),
                            ))
                        : Scaffold(
                            appBar: AppBar(
                                title: Text('Employee Pannel'),
                                actions: <Widget>[]),
                            body: Text('Error, Product not found!'),
                          );
                  }));
                });
              } else {
                null;
              }
            },
            child: Text('See Product'))
      ],
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onQrViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(
        //                    <--- top side
        color: Colors.black,
        width: 1.0,
      ),
    ),
  );
}
