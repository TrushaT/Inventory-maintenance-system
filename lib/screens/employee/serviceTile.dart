import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/models/service.dart';
import 'package:inventory_management/models/user.dart';

final DateFormat formatter = DateFormat('dd-MM-yyyy');

class ServiceTile extends StatelessWidget {
  final Service service;
  ServiceTile(this.service);
  @override
  Widget build(BuildContext context) {
    final DateTime _dateTime = DateTime.parse(service.date_of_service);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(
              "${service.productType} ${_dateTime.day}-${_dateTime.month}-${_dateTime.year}"),
          subtitle: Text(service.description),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blueAccent,
            child: Image.asset('assets/profile.jpg'),
          ),
        ),
      ),
    );
  }
}
