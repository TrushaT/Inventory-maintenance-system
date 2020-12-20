import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/models/service.dart';
import 'package:inventory_management/screens/employee/serviceTile.dart';
import 'package:inventory_management/services/employees.dart';
import 'package:inventory_management/shared/loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Service> services_list;
  CollectionReference service =
      FirebaseFirestore.instance.collection('Services');
  String userId;
  EmployeeService _employeeService = EmployeeService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> data;

  @override
  void initState() {
    final User user = auth.currentUser;
    userId = user.uid;
    print('$userId');
    getServices();

    super.initState();
  }

//  Future getServices() async {
//     List<Service> services = [];
//    await service.getDocuments().then((QuerySnapshot snapshot) => {
//           snapshot.documents.forEach((DocumentSnapshot doc) {
//             if (true) {
//               services.add(new Service(
//                     doc.data()["uid"],
//                     doc.data()["product_id"],
//                     doc.data()["cost"],
//                     doc.data()["date_of_service"],
//                     doc.data()["description"],
//                     doc.documentID,
//                   ));
//             }
//           })

//         });
//         setState(() {
//           services_local = services;
//         });
//   }

  Future getServices() async {
    services_list = await _employeeService.getServices(this.userId);
    setState(() {
      services_list = services_list;
    });
  }

  // Future getDocs() async {
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection("Services").where('uid', isEqualTo: userId).get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //     print(a);
  //   }
  // }

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
    Container(
      child: Center(
        child: Text('Your Recent Services'),
      ),
      padding: EdgeInsets.all(5),
    );
    print(services_list);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Services')
          .where('uid', isEqualTo: userId)
          .orderBy('date_of_service', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return services_list == null
            ? Container(child: Loading())
            : ListView.builder(
                itemCount: services_list.length,
                itemBuilder: (context, index) {
                  print(services_list[index].service_id);
                  return Container(
                    child: ServiceTile(services_list[index]),
                  );
                });
      },
    );
  }
}
