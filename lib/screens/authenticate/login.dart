import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inventory_management/models/user.dart';
import 'package:inventory_management/screens/homepage/admin_homepage.dart';
import 'package:inventory_management/screens/homepage/employee_homepage.dart';
import 'package:inventory_management/screens/homepage/manager_homepage.dart';
import 'package:inventory_management/services/auth.dart';
import 'package:inventory_management/shared/constants.dart';
import 'package:inventory_management/shared/loading.dart';
import 'package:inventory_management/shared/rounded_input_field.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  Future signIn(String email, String password) async {
    print(1);
    dynamic result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print("Result");
    print(result);
    if (result == null) {
      setState(() {
        loading = false;
      });
      print("error");
    } else {
      dynamic u = await _auth.getUserData(result.uid);
      //abruptly starting this...
      print("u");
      print(u);
      if (u.user_type == 'manager') {
        String department = u.department;
        print(department);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ManagerHomePage(department)),
            (Route<dynamic> route) => false);
      } else if (u.user_type == 'employee') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      } else if (u.user_type == 'admin') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminHomePage()),
            (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              elevation: 0.0,
              title: Text('LOGIN'),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('INVENTORY',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Card(
                        child: Image.asset('assets/InventoryManagement.png'),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Email'),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(height: size.height * 0.03),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Password'),
                                validator: (val) => val.length < 6
                                    ? 'Enter a password 6+chars long'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                obscureText: true,
                              ),
                              SizedBox(height: size.height * 0.03),
                              SizedBox(height: 20),
                              ButtonTheme(
                                  minWidth: 200.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      onPressed: () {
                                        if (_formkey.currentState.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          signIn(email, password);
                                        }
                                      },
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ))),
                            ],
                          ))
                    ],
                  ),
                )));
  }
}
