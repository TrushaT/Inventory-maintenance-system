import 'package:flutter/material.dart';
import 'package:inventory_management/models/service.dart';
import 'package:inventory_management/models/user.dart';
import 'package:inventory_management/screens/employee/employee_tile.dart';
import 'package:inventory_management/screens/employee/serviceTile.dart';
import 'package:provider/provider.dart';

class ServiceList extends StatefulWidget {
  
  final List<Service> service_list;
  ServiceList(this.service_list);

  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    // final employees = Provider.of<List<Inventory_User>>(context) ?? [];
    // print("From Provider");
    // print(employees);
   
    return widget.service_list == null
        ? Container(child: Text('Loading'))
        : Scaffold(
          appBar: AppBar(
            title:Text("Employee Pannel")
          ),
            body: ListView.builder(
                itemCount: widget.service_list.length,
                itemBuilder: (context, index) {
                  print(widget.service_list[index].service_id);
                  return Container(
                    child: ServiceTile(widget.service_list[index]),
                  );
                }));
  }
}
