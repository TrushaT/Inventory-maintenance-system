import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/models/service.dart';
import 'package:inventory_management/screens/employee/serviceTile.dart';
import 'package:inventory_management/services/employees.dart';
import 'package:inventory_management/shared/loading.dart';

class ServiceDetails extends StatefulWidget {
  
  const ServiceDetails({this.employee_id});
  final String employee_id;
  
  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  List<Service> services_list;
  CollectionReference service =
      FirebaseFirestore.instance.collection('Services');
  String userId;
  EmployeeService _employeeService = EmployeeService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> data;

  @override
  void initState() {
    userId = widget.employee_id;
    print('$userId');
    getServices();

    super.initState();
  }

  Future getServices() async {
    services_list = await _employeeService.getServices(this.userId);
    setState(() {
      services_list = services_list;
    });
  }

  void productDetails(String pId) {
    FirebaseFirestore.instance
        .collection('product')
        .doc(pId)
        .get()
        .then((DocumentSnapshot doc) {
      setState(() {
        data = doc.data();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(services_list);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Services')
          .where('uid', isEqualTo: userId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return services_list == null
            ? Container(child: Loading())
            : Scaffold(
              appBar: AppBar(
                title : Text('Employee Service Record'),
              ),
              body : services_list.length == 0 ? 
              Center(
                child :Container(
                child: Text('No Records',style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),)))
              : ListView.builder(
                  itemCount: services_list.length,
                  itemBuilder: (context, index) {
                    print(services_list[index].service_id);
                    return Container(
                      child: ServiceTile(services_list[index]),
                    );
                  })
                );
      },
    );
  }
}
