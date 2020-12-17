import 'package:flutter/material.dart';
import 'package:inventory_management/models/user.dart';
import 'package:inventory_management/screens/employee/employee_list.dart';
import 'package:inventory_management/screens/homepage/employee_homepage.dart';
import 'package:inventory_management/services/employees.dart';
import 'package:provider/provider.dart';
import 'package:inventory_management/screens/manager/fancy_fab.dart';

class ManagerHomePage extends StatefulWidget {
  final String department;
  const ManagerHomePage(this.department);
  @override
  State<StatefulWidget> createState() {
    return _ManagerHomePageState();
  }
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  EmployeeService _employeeService = EmployeeService();
  List<Inventory_User> employee_list;

  void initState() {
    getEmployeeList();
    super.initState();
  }

  Future getEmployeeList() async {
    employee_list = await _employeeService.getEmployees(widget.department);
    setState(() {
      employee_list = employee_list;
    });
    print("Employee list1");
    print(this.employee_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Portal'),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
      ),
      body: Column(children: [
        Container(child: EmployeeList(employee_list: employee_list))
      ]),
      floatingActionButton: FancyFab(),
    );
  }
}
