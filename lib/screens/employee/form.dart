import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/shared/constants.dart';
import 'package:inventory_management/shared/toast.dart';
import './firebase.dart';

// class FormApp extends StatelessWidget {
//   const FormApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: MyCustomForm());
//   }
// }

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final String productId, productType;
  const MyCustomForm(this.productId, this.productType);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final text = new TextEditingController();
  final textdescription = new TextEditingController();
  final textcost = new TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime _dateTime;
  CustomToast toast = CustomToast();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    Size size = MediaQuery.of(context).size;
    print(widget.productId);
    return MaterialApp(
        title: 'Service',
        home: Scaffold(
            appBar: AppBar(
              title: Text("Employee Panel"),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Please Enter Service Description'),
                          controller: textdescription),
                      SizedBox(height: size.height * 0.03),
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Please Enter Service Cost'),
                          controller: textcost),
                      SizedBox(height: size.height * 0.04),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(_dateTime == null
                            ? 'Nothing has been picked yet'
                            : "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}"),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Row(
                        children: [
                          ButtonTheme(
                            height: 50.0,
                            child: RaisedButton(
                              child: IconTheme(
                                data: IconThemeData(color: Colors.white),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: _dateTime == null
                                            ? DateTime.now()
                                            : _dateTime,
                                        firstDate: DateTime(2001),
                                        lastDate: DateTime(2021))
                                    .then((date) {
                                  setState(() {
                                    _dateTime = date;
                                  });
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(_dateTime == null
                                ? 'Nothing has been picked yet'
                                : "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}"),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      ButtonTheme(
                          height: 50.0,
                          minWidth: 250,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            color: Colors.green,
                            onPressed: () {
                              serviceSetup(
                                  widget.productId,
                                  textdescription.text,
                                  textcost.text,
                                  Timestamp.fromDate(_dateTime),
                                  widget.productType);
                              toast.showToast('Service Details Added',
                                  Colors.green, Colors.white);
                            },
                            child: Text(
                              'Add Service',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )));
  }
}
