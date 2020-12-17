import 'package:flutter/material.dart';
import 'package:inventory_management/models/user.dart';
import 'package:inventory_management/screens/employee/add_employee_form.dart';
import 'package:inventory_management/screens/employee/employee_list.dart';
import 'package:inventory_management/screens/homepage/employee_homepage.dart';
import 'package:inventory_management/services/employees.dart';
import 'package:provider/provider.dart';

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
    void _showAddEmployeePanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: AddEmployeeForm(),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
          );
        },
        isScrollControlled: true,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Manager Portal'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              child: Text('MANAGER PORTAL'),
            ),
            Container(child: EmployeeList(employee_list: employee_list)),
            ButtonTheme(
                minWidth: 200.0,
                height: 40.0,
                child: RaisedButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {
                      _showAddEmployeePanel();
                    },
                    
          ],
        ));
  }
}
