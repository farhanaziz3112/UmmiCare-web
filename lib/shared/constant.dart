import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.grey),
    borderRadius: const BorderRadius.all(
      const Radius.circular(30.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.black),
    borderRadius: const BorderRadius.all(
      const Radius.circular(15.0),
    ),
  ),
  // enabledBorder: OutlineInputBorder(
  //     borderSide: BorderSide(color: Colors.white, width: 2.0),
  //   ),
  // focusedBorder: OutlineInputBorder(
  //     borderSide: BorderSide(color: Color.fromARGB(255, 88, 87, 87), width: 2.0)),
);
