import 'dart:convert';
import 'dart:ui';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate>
    with SingleTickerProviderStateMixin {
  // String imageUrl;

  String word;
  DateTime dateAdded;
  DateTime warranty;
  DateTime endOfLife;
  String productType;
  String description;
  String department;
  DateTime nextServiceDate;
  String cost;
  String status;

  bool color = false;

  GlobalKey imageKey = GlobalKey();

  Color pickerColor = new Color(0xff443a49);

  AnimationController _animationController;

  final myControllerProductType = TextEditingController();
  final myControllerDescription = TextEditingController();
  final myControllerDepartment = TextEditingController();
  final myControllerCost = TextEditingController();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    super.initState();

    dateAdded = new DateTime.now();
    warranty = new DateTime.now();
    endOfLife = new DateTime.now();
    nextServiceDate = new DateTime.now();
  }

  // createQrCode(color) async {
  //   // var uri = (Uri.parse("https://codzz-qr-cods.p.rapidapi.com/getQrcode"));
  //   // var response = await http.get(
  //   //     uri.replace(queryParameters: <String, String>{
  //   //       // "type": "text %7C url %7C tel %7C sms %7C email",
  //   //       // "text": text,
  //   //       // "backcolor": "00237c",
  //   //       // "pixel": "9",
  //   //       // "ecl": "L %7C M%7C Q %7C H",
  //   //       // "forecolor": color,
  //   //       "type": "text",
  //   //       "value": text
  //   //     }),
  //   //     headers: {
  //   //       "x-rapidapi-key":
  //   //           "a2f787957dmshb8dd1e8639b169cp155072jsnd92fd1c0c90a",
  //   //       "x-rapidapi-host": "codzz-qr-cods.p.rapidapi.com",
  //   //       "useQueryString": "true"
  //   //     });

  //   setState(() {
  //     // imageUrl = response.body;

  //   });
  // }
  postData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("product").doc();

    Map<String, dynamic> product = {
      "dateAdded": dateAdded,
      "warranty": warranty,
      "cost": cost,
      "nextServiceDate": nextServiceDate,
      "department": department,
      "description": description,
      "productType": productType,
      "endOfLife": endOfLife,
      "status": "working",
    };

    documentReference.set(product).whenComplete(() => print("Posted Data!"));
    setState(() {
      word = documentReference.id;
    });
  }

  Future<void> shareImage() async {
    RenderRepaintBoundary imageObject =
        imageKey.currentContext.findRenderObject();
    final image = await imageObject.toImage(pixelRatio: 2);
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);

    final pngBytes = byteData.buffer.asUint8List();
    final base64String = base64Encode(pngBytes);

    await Share.file('qr image', 'qr.png', pngBytes, 'image/png',
        text: 'QR Code for " $productType " of department " $department "');
  }

  void _handleOnPressed() {
    setState(() {
      color = !color;
      color ? _animationController.forward() : _animationController.reverse();
    });
  }

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  pickDatePurchase() async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: dateAdded,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (dateTime != null) {
      setState(() {
        dateAdded = dateTime;
      });
    }
  }

  pickDateWarranty() async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: dateAdded,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (dateTime != null) {
      setState(() {
        warranty = dateTime;
      });
    }
  }

  pickDateEndOfLife() async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: dateAdded,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (dateTime != null) {
      setState(() {
        endOfLife = dateTime;
      });
    }
  }

  pickDateNextService() async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: dateAdded,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (dateTime != null) {
      setState(() {
        nextServiceDate = dateTime;
      });
    }
  }

  Widget OurInput(String hint, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
      height: 40,
      width: 300,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Colors.white70),
      child: Center(
        child: ListTile(
          title: Container(
            padding: EdgeInsets.only(bottom: 10, left: 10),
            child: TextFormField(
              cursorColor: Colors.black,
              controller: controller,
              decoration: new InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/frame.png'),
                ),
              ),
              word == null
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 50),
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/qr.png'),
                      ),
                    )
                  : Center(
                      child: RepaintBoundary(
                        key: imageKey,
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0, bottom: 10.0),
                          padding: EdgeInsets.only(top: 50),
                          child: QrImage(
                              data: word,
                              version: QrVersions.auto,
                              foregroundColor: pickerColor,
                              backgroundColor: Colors.white),
                          height: 150,
                          width: 160,
                        ),
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            padding: EdgeInsets.all(10),
            duration: Duration(milliseconds: 450),
            width: 300,
            height: color == false ? 70 : 280,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 51, 145, 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 100),
                        child: Row(
                          children: [
                            Text(
                              "COLOR",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: pickerColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.menu_arrow,
                          color: Colors.white,
                          progress: _animationController,
                        ),
                        onPressed: () {
                          _handleOnPressed();
                        },
                      )
                    ],
                  ),
                  color == true
                      ? Container(
                          height: 200,
                          child: MaterialPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                            enableLabel: true,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
            height: 60,
            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.white70),
            child: Center(
              child: ListTile(
                title: Text(
                    "Product Purchase Date: ${dateAdded.year}/${dateAdded.month}/${dateAdded.day}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: pickDatePurchase,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
            height: 60,
            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.white70),
            child: Center(
              child: ListTile(
                title: Text(
                    "Product Warranty Date: ${warranty.year}/${warranty.month}/${warranty.day}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: pickDateWarranty,
              ),
            ),
          ),
          OurInput("Enter Product Type", myControllerProductType),
          OurInput("Enter Product Description", myControllerDescription),
          OurInput("Enter Product Department", myControllerDepartment),
          Container(
            margin: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
            height: 60,
            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.white70),
            child: Center(
              child: ListTile(
                title: Text(
                    "Product End Of Date: ${endOfLife.year}/${endOfLife.month}/${endOfLife.day}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: pickDateEndOfLife,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, top: 10.0, right: 30.0),
            height: 60,
            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.white70),
            child: Center(
              child: ListTile(
                title: Text(
                    "Product Service Date: ${nextServiceDate.year}/${nextServiceDate.month}/${nextServiceDate.day}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: pickDateNextService,
              ),
            ),
          ),
          OurInput("Enter Product Cost", myControllerCost),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 50),
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color.fromRGBO(0, 180, 245, 1)),
                child: FlatButton(
                    onPressed: () {
                      // createQrCode(
                      //       null,
                      //     "${pickerColor.red.toRadixString(16)}${pickerColor.green.toRadixString(16)}${pickerColor.blue.toRadixString(16)}"
                      //     );
                      setState(() {
                        productType = myControllerProductType.text;
                        description = myControllerDescription.text;
                        department = myControllerDepartment.text;
                        cost = myControllerCost.text;
                      });
                      postData();
                    },
                    child: Text(
                      "Generate QR",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 50, left: 20),
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Color.fromRGBO(0, 180, 245, 1)),
                    child: FlatButton(
                        onPressed: () {
                          shareImage();
                        },
                        child: Text(
                          "Save QR",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
