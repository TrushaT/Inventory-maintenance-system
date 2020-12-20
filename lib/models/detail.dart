import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Detail {
  String cost;
  String department;
  String description;
  String productType;
  String status;

  Detail(
      {this.cost,
      this.department,
      this.description,
      this.productType,
      this.status});

  factory Detail.fromJson(dynamic json) {
    return Detail(
      description: "${json['description']}",
      cost: "${json['cost']}",
      department: "${json['department']}",
      productType: "${json['productType']}",
      status: "${json['status']}",
    );
  }

  Map toJson() => {
        "cost": cost,
        "department": department,
        "description": description,
        "productType": productType,
        "status": status
      };
}
