import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/screens/homepage/manager_homepage.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/employees.dart';
import 'package:inventory_management/shared/constants.dart';
import 'package:inventory_management/models/user.dart';

class AddEmployeeForm extends StatefulWidget {
  final String department;
  const AddEmployeeForm(this.department);
  
  @override
  _AddEmployeeFormState createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final _formkey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  String name;
  final String user_type = 'employee';
  String department;
  Timestamp date_of_joining = Timestamp.fromDate(DateTime.now());
  String mobile_number;
  String email;

  void addEmployee(name, user_type, date_of_joining, department, mobile_number,
      email) async {
    String password = name + department;
    print(email);
    print(password);

    dynamic result =
        await authService.registerWithEmailAndPassword(email, password);
    print(result.uid);
    dynamic user = await EmployeeService().updateUserData(
        uid: result.uid,
        name: name,
        user_type: user_type,
        date_of_joining: date_of_joining,
        department: department,
        mobile_number: mobile_number,
        email: email);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder:(context) => ManagerHomePage(department)),
      (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text("New Employee"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0, top: 15.0),
                child: GestureDetector(
                  onTap: () {
                    addEmployee(name, user_type, date_of_joining, department=widget.department,
                        mobile_number, email);
                  },
                  child: Text("SAVE",
                      style: TextStyle(color: Colors.white, fontSize: 17.0)),
                )),
          ],
        ),
        body: (SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(children: [
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter name'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  }),
              SizedBox(height: 20),
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter Email'),
                  validator: (val) => val.isEmpty ? 'Please enter email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  }),
              SizedBox(height: 20),
              TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter Mobile Number'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) {
                    setState(() {
                      mobile_number = val;
                    });
                  }),
              SizedBox(height: 20),
            ]),
          ),
        )));
  }
}
