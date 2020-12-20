import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import './product_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import './form.dart';

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
  QRViewController controller;
  User user = FirebaseAuth.instance.currentUser;

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
                    }
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return showProduct
                          ? Scaffold(
                              appBar: AppBar(
                                  title: Text('Employee Panel'),
                                  actions: <Widget>[]),
                              body: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Table(
                                      border: TableBorder.all(
                                          color: Colors.black26, width: 3),
                                      children: [
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                              child: Text(
                                                'Product Description',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["description"],
                                              style: TextStyle(fontSize: 25),
                                            )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              'Product Status',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["status"],
                                              style: TextStyle(fontSize: 25),
                                            )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              'Product Type',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["productType"],
                                              style: TextStyle(fontSize: 25),
                                            )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              'Product Cost',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["cost"],
                                              style: TextStyle(fontSize: 25),
                                            )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              'Department',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["department"],
                                              style: TextStyle(fontSize: 25),
                                            )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              'Product Date Added',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["dateAdded"]
                                                  .toDate()
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 25,
                                              ),
                                            )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                                child: Text('Warranty',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left)),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["warranty"]
                                                  .toDate()
                                                  .toString(),
                                              style: TextStyle(fontSize: 25),
                                            )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              'Product End of Life',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["endOfLife"]
                                                  .toDate()
                                                  .toString(),
                                              style: TextStyle(fontSize: 25),
                                            )),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              'Product Next Service Date',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          TableCell(
                                            child: Center(
                                                child: Text(
                                              data["nextServiceDate"]
                                                  .toDate()
                                                  .toString(),
                                              style: TextStyle(fontSize: 25),
                                            )),
                                          )
                                        ]),

                                        // Container(
                                        //   child: Center(
                                        //     child: Text(
                                        //       "Product Name",
                                        //       style: TextStyle(
                                        //           fontWeight: FontWeight.bold,
                                        //           fontSize: 30),
                                        //     ),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //     "Product Description  :",
                                        //     style: TextStyle(fontSize: 35),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   child: Center(
                                        //     child: Text(data["description"],
                                        //         style: TextStyle(fontSize: 16),
                                        //         textAlign: TextAlign.justify),
                                        //   ),
                                        //   padding: const EdgeInsets.all(25),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //       "Product Status  :  " + data["status"],
                                        //       style: TextStyle(fontSize: 35),
                                        //       textAlign: TextAlign.justify),
                                        //   alignment: Alignment.centerLeft,
                                        //   padding: const EdgeInsets.all(35),
                                        //   margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //       "Product Cost  :  " + data["cost"],
                                        //       style: TextStyle(fontSize: 35),
                                        //       textAlign: TextAlign.justify),
                                        //   alignment: Alignment.centerLeft,
                                        //   padding: const EdgeInsets.all(35),
                                        //   margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //       "Product Added Date  : " +
                                        //           data["dateAdded"]
                                        //               .toDate()
                                        //               .toString(),
                                        //       style: TextStyle(fontSize: 35),
                                        //       textAlign: TextAlign.justify),
                                        //   alignment: Alignment.centerLeft,
                                        //   padding: const EdgeInsets.all(35),
                                        //   margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //       "Waranty  : " +
                                        //           data["warranty"]
                                        //               .toDate()
                                        //               .toString(),
                                        //       style: TextStyle(fontSize: 35),
                                        //       textAlign: TextAlign.justify),
                                        //   alignment: Alignment.centerLeft,
                                        //   padding: const EdgeInsets.all(35),
                                        //   margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //       "End of Life  : " +
                                        //           data["endOfLife"]
                                        //               .toDate()
                                        //               .toString(),
                                        //       style: TextStyle(fontSize: 35),
                                        //       textAlign: TextAlign.justify),
                                        //   alignment: Alignment.centerLeft,
                                        //   padding: const EdgeInsets.all(35),
                                        //   margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //       "Next Service Date  : " +
                                        //           data["nextServiceDate"]
                                        //               .toDate()
                                        //               .toString(),
                                        //       style: TextStyle(fontSize: 35),
                                        //       textAlign: TextAlign.justify),
                                        //   alignment: Alignment.centerLeft,
                                        //   padding: const EdgeInsets.all(35),
                                        //   margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //       "Product Type  : " +
                                        //           data["productType"],
                                        //       style: TextStyle(fontSize: 35),
                                        //       textAlign: TextAlign.justify),
                                        //   alignment: Alignment.centerLeft,
                                        //   padding: const EdgeInsets.all(35),
                                        //   margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                        // Container(
                                        //   child: Text(
                                        //       "Department  : " + data["department"],
                                        //       style: TextStyle(fontSize: 35),
                                        //       textAlign: TextAlign.justify),
                                        //   alignment: Alignment.centerLeft,
                                        //   padding: const EdgeInsets.all(35),
                                        //   margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        //   decoration: myBoxDecoration(),
                                        // ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 35, 0, 40),
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
                                            return MyCustomForm(
                                                qrText.toString());
                                          }))
                                        },
                                        color: Colors.white,
                                        child: Container(
                                          child: Text("Add Service"),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.green)),
                                      ),
                                    )
                                  ],
                                ),
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
      ),
    );
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
