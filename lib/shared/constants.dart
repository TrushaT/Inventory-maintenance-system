import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  // fillColor: Colors.blueAccent,
  contentPadding: EdgeInsets.all(20.0),
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: Colors.blueGrey, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(20.0),
      ),
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0)),
);
