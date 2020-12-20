import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/services/employees.dart';
import 'package:inventory_management/shared/constants.dart';

class AddManagerForm extends StatefulWidget {
  @override
  _AddManagerFormState createState() => _AddManagerFormState();
}

class _AddManagerFormState extends State<AddManagerForm> {
  final _formkey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  String name;
  final String user_type = 'manager';
  Timestamp date_of_joining = Timestamp.fromDate(DateTime.now());
  String department;
  String mobile_number;
  String email;

  void addManager(name, user_type, date_of_joining, department, mobile_number,
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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Manager'),
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(children: [
              Text(
                'Add Manager',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
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
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter Department'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter department' : null,
                  onChanged: (val) {
                    setState(() {
                      department = val;
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
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Enter Mobile Number'),
                validator: (val) =>
                    val.isEmpty ? 'Please enter a Mobile Number' : null,
                onChanged: (val) {
                  setState(() {
                    mobile_number = val;
                  });
                },
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              RaisedButton(
                  onPressed: () {
                    addManager(name, user_type, date_of_joining, department,
                        mobile_number, email);
                  },
                  color: Colors.blueAccent,
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ))
            ]),
          ),
        ));
  }
}
