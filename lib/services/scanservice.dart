import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/models/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class ScanService {
  final CollectionReference scanCollection =
      FirebaseFirestore.instance.collection('ScanLog');

  List<Scan> scan_list = [];

  User user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();

  // Future getdepartment() async {
  //   print('inscanservice - getdepartment');
  //   dynamic u = await _auth.getUserData(user.uid);
  //   return u.department.toString();
  // }

  Future<List<Scan>> getScan() async {
    print('inscanservice - getScan');

    // print(getdepartment());
    dynamic u = await _auth.getUserData(user.uid);
    print(u.department);
    await scanCollection
        .where("department", isEqualTo: u.department)
        .get()
        .then((value) => value.docs.forEach((element) {
              if (element.exists) {
                print(element);
                print(element.data()['scandate']);
                print(element.data()['employee_id']);
                print(element.data()['product_id']);
                print(element.data()['employee_name']);

                scan_list.add(Scan(
                  scandate: element.data()['scandate'],
                  employee_id: element.data()['employee_id'],
                  product_id: element.data()['product_id'],
                  department: element.data()['department'],
                  employee_name: element.data()['employee_name'],
                ));
              }

              // FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(element.data()['employee_id'])
              //     .get()
              //     .then((DocumentSnapshot doc) {
              //   scan_list.add(Scan(
              //     scandate: element.data()['scandate'],
              //     employee_id: element.data()['employee_id'],
              //     product_id: element.data()['product_id'],
              //     department: element.data()['department'],
              //     employee_name: element.data()['employee_name'],
              //   ));
            }));
    print(scan_list);
    return (scan_list);
  }
}
