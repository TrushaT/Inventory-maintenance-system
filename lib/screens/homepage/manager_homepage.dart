import 'package:flutter/material.dart';
import 'package:inventory_management/models/user.dart';
import 'package:inventory_management/screens/employee/employee_list.dart';
import 'package:inventory_management/screens/homepage/employee_homepage.dart';
import 'package:inventory_management/screens/manager/add_employee.dart';
import 'package:inventory_management/screens/manager/scanlog.dart';
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
  List<Inventory_User> results_employee_list;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    getEmployeeList();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    searchResultsList();
  }

  void searchResultsList() {
    List<Inventory_User> showResults = [];

    if (_searchController.text != "") {
      for (var employee in employee_list) {
        var name = employee.name.toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(employee);
        }
      }
    } else {
      showResults = List.from(employee_list);
    }
    setState(() {
      results_employee_list = showResults;
    });
  }

  Future getEmployeeList() async {
    employee_list = await _employeeService.getEmployees(widget.department);
    setState(() {
      employee_list = employee_list;
    });
    searchResultsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Portal'),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0, top: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScanLog()));
                },
                child: Icon(
                  Icons.assignment,
                  size: 30.0,
                ),
              )),
        ],
      ),
      body: Column(children: [
        Container(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search by Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: TextStyle(
              fontSize: 19,
            ),
            autofocus: false,
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        ),
        Container(child: EmployeeList(employee_list: results_employee_list))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEmployeeForm(widget.department)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
