import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String uid;
  final String product_id;
  final String cost;
  final String date_of_service;
  final String description;
  final String service_id;
  final String productType;


  Service(this.uid, this.product_id, this.cost, this.date_of_service,
      this.description, this.service_id,this.productType);
}
