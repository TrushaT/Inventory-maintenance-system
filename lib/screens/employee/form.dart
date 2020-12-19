import 'package:flutter/material.dart';
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
  final String productId;
  const MyCustomForm(this.productId);

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
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    Size size = MediaQuery.of(context).size;
    print(widget.productId);
    return MaterialApp(
        title: 'Service',
        home: Scaffold(
            appBar: AppBar(
              title: Text("Employee Pannel"),
            ),
            body: Form(
              key: _formKey,
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
                      decoration:
                          InputDecoration(hintText: 'Enter Your Details'),
                      controller: textdescription),
                  SizedBox(height: size.height * 0.03),
                  TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(hintText: 'Enter Your Details'),
                      controller: textcost),
                  Text(_dateTime == null
                      ? 'Nothing has been picked yet'
                      : _dateTime.toString()),
                  RaisedButton(
                    child: Text('Pick a date'),
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
                  SizedBox(height: size.height * 0.03),
                  RaisedButton(
                      onPressed: () => {
                            serviceSetup(widget.productId, textdescription.text,
                                textcost.text, _dateTime.toString())
                          },
                      child: Text("Submit"))
                ],
              ),
            )));
  }
}
