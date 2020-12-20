import 'package:flutter/material.dart';
import 'package:inventory_management/models/scan.dart';
import 'scan_tile.dart';
import 'package:inventory_management/shared/loading.dart';

class ScanList extends StatefulWidget {
  List<Scan> scan_list;
  ScanList({this.scan_list});

  @override
  _ScanListState createState() => _ScanListState();
}

class _ScanListState extends State<ScanList> {
  @override
  Widget build(BuildContext context) {
    print('inscanlist');
    print(widget.scan_list);
    return widget.scan_list == null
        ? Container(child: Loading())
        : Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.scan_list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: ScanTile(scan: widget.scan_list[index]),
                        );
                      }))
            ],
          );
  }
}
