import 'package:flutter/material.dart';

class ProductDisplay extends StatefulWidget {
  ProductDisplay({Key key}) : super(key: key);

  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Container(
            child: Center(
              child: Text(
                "Product Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            padding: const EdgeInsets.all(30),
            decoration: myBoxDecoration(),
          ),
          Container(
            child: Text(
              "Product Description  :",
              style: TextStyle(fontSize: 20),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(5, 15, 0, 0),
          ),
          Container(
            child: Center(
              child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify),
            ),
            padding: const EdgeInsets.all(25),
            decoration: myBoxDecoration(),
          ),
          Container(
            child: Text("Product Status  :   Active",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.justify),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: myBoxDecoration(),
          ),
          Container(
            child: Text("Product Cost  :   70",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.justify),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: myBoxDecoration(),
          ),
          Container(
            child: Text("Product Added Date  :   17/12/2020 ",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.justify),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: myBoxDecoration(),
          ),
          Container(
            child: Text("Waranty  :   1 Year",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.justify),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: myBoxDecoration(),
          ),
          Container(
            child: Text("End of Life  :   10 Years",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.justify),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: myBoxDecoration(),
          ),
          Container(
            child: Text("Next Service Date  :   16/12/2021",
                style: TextStyle(fontSize: 20), textAlign: TextAlign.justify),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: myBoxDecoration(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
            child: MaterialButton(
              height: 50.0,
              minWidth: 3 * MediaQuery.of(context).size.width / 4,
              onPressed: () => {},
              color: Colors.white,
              child: Container(
                child: Text("Add Service"),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
            ),
          )
        ],
      )),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(
        //                    <--- top side
        color: Colors.black,
        width: 1.0,
      ),
    ),
  );
}
