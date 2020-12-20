import 'package:cloud_firestore/cloud_firestore.dart';

class Scan {
  final Timestamp scandate;
  final String employee_id;
  final String product_id;
  final String department;
  final String employee_name;
  Scan({
    this.scandate,
    this.employee_id,
    this.product_id,
    this.department,
    this.employee_name,
  });
}
