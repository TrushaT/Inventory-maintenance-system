import 'package:flutter/material.dart';
import 'package:inventory_management/models/scan.dart';
import 'package:inventory_management/services/scanservice.dart';
import 'scan_list.dart';

class ScanLog extends StatefulWidget {
  @override
  _ScanLogState createState() => _ScanLogState();
}

class _ScanLogState extends State<ScanLog> {
  ScanService _scanService = ScanService();
  List<Scan> scan_list;

  @override
  void initState() {
    print('here1');
    getScanList();
    super.initState();
  }

  Future getScanList() async {
    print('here2');
    scan_list = await _scanService.getScan();
    setState(() {
      scan_list = scan_list;
      print(scan_list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scan Records'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
        ),
        body: Container(child: ScanList(scan_list: scan_list)));
        //body: Text('Scan Records'));
  }
}
