import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management/models/detail.dart';
import 'dart:convert' as convert;

class Sheets extends StatefulWidget {
  @override
  _SheetsState createState() => _SheetsState();
}

class _SheetsState extends State<Sheets> {
  List<Detail> details = List<Detail>();

  getDetailsFromSheet() async {
    var raw = await http.get(
        "https://script.google.com/macros/s/AKfycbylZY9-LDv-sNocysl5TIpxhsrTpoVxN5urARt7BsP3MoO36Dk/exec");
    print(raw);
    print(raw.body);
    var jsondetail = convert.jsonDecode(raw.body);
    print('this is json detail $jsondetail');
  }

  @override
  void initState() {
    print('inside sheet');
    getDetailsFromSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SheetData'),
      ),
      body: Container(),
    );
  }
}

class DetailTile extends StatelessWidget {
  String cost, department, description, productType, status;
  DetailTile({
    this.cost,
    this.department,
    this.description,
    this.productType,
    this.status,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [Text(description)],
          )
        ],
      ),
    );
  }
}
