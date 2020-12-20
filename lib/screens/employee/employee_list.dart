import 'package:flutter/material.dart';
import 'package:inventory_management/models/user.dart';
import 'package:inventory_management/screens/employee/employee_tile.dart';
import 'package:inventory_management/shared/loading.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatefulWidget {
  List<Inventory_User> employee_list;
  EmployeeList({this.employee_list});

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
    // final employees = Provider.of<List<Inventory_User>>(context) ?? [];
    // print("From Provider");
    // print(employees);

    return widget.employee_list == null
        ? Container(child: Loading())
        : widget.employee_list.length == 0 ?
        Center(
                child :Container(
                child: Text('No Employees',style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),)))
        : Expanded(
            child: ListView.builder(
                itemCount: widget.employee_list.length,
                itemBuilder: (context, index) {
                  print(widget.employee_list[index].name);
                  return Container(
                    child: EmployeeTile(employee: widget.employee_list[index]),
                  );
                }));
  }
}
